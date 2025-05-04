import 'dart:convert';
import 'dart:io';

import 'logger_wrapper.dart';
import 'package:tester/pages/console.dart';
import 'package:path_provider/path_provider.dart';


class AppConfig 
{
  static final AppConfig _instance = AppConfig._internal();

  AppConfig._internal();

  static AppConfig get instance => _instance;

  // application configuration
  String packVersion = "0.0.0";
  String appVersion  = "0.0.0";
  late String gAppVersion;
  late String gPackVersion;

  late String minecraftVersion;
  final minecraftDirs = getApplicationDocumentsDirectory();
  // late String javaVersion;
  
  // link to global configuration
  late Uri globalConfigUrl;

  // --------------- hardware specs ---------------
  late int?    ramSize;   // ram size in gb
  late String? cpuName;   // cpu model name
  late String? gpuName;   // gpu name

  // ---------------  read specs    ---------------
  static Future<String?> readGpuName() async 
  {
    var result = await Process.run('powershell', [
      'Get-CimInstance Win32_VideoController | Select-Object Name']);

    var output = result.stdout.toString().trim().split('\n');

    if (output.length > 2) {
      return output.skip(2).join('\n').trim();
    }

    return null;
  }

  static Future<String?> readCpuName() async 
  {
    var result = await Process.run('powershell', [
      'Get-WmiObject win32_processor | Select-Object Name', ]);
    var output = result.stdout.toString().trim().split('\n');

    if (output.length > 2) {
      return output.skip(2).join('\n').trim(); 
    }
    return null;
  }
  
  Future<int?> readRam() async 
  {
    var result = await Process.run('powershell', [
      'Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | ForEach-Object { \$_.Sum / 1GB }'
    ]);

    return int.parse(result.stdout.toString().trim());
  }

  // ------------- read app json ---------------
  Future<bool> readLocalAppJson() async 
  {
    String? homeDir = Platform.environment['APPDATA'];
    final localPath = "$homeDir\\Ivoryc\\local.json";

    final data = await readJsonFile(localPath);

    if (data['launcher'] == null || data['launcher']['version'] == null) {
      AppLogger().e('Invalid JSON structure - missing launcher version');
      return false;
    }

    appVersion  = data['launcher']['version'];
    packVersion = data['modpack']['version'];
    minecraftVersion = data['minecraft']['version'];

    globalConfigUrl = Uri.parse(data['settings']['global_url']); 


    AppLogger().i('LPackVer: $packVersion');
    AppLogger().i('LVersion: $appVersion');
    return true;
  }

  Future<bool> readGlobalAppJson() async
  {
    final globalResponse = await HttpClient().getUrl(globalConfigUrl);
    final global = await globalResponse.close();
    final globalJson = jsonDecode(await global.transform(utf8.decoder).join());

    if (globalJson['launcher'] == null || globalJson['launcher']['version'] == null) {
      AppLogger().e('Invalid JSON structure - missing launcher version');
      return false;
    }

    gPackVersion = globalJson['modpack']['version'];
    gAppVersion  = globalJson['launcher']['version'];

    AppLogger().i("GPackVer: $gPackVersion");
    AppLogger().i("GVersion: $gAppVersion");
  
    return true;
  }

  // --------------- getters     ---------------

  int? getRamSize() => ramSize;
  String? getCpuName() => cpuName;
  String? getGpuName() => gpuName;


  // --------------- other methods ---------------
  Future<void> readHWSpecs() async
  {
    cpuName = await readCpuName();
    gpuName = await readGpuName();
    ramSize = await readRam();

    AppLogger().i("cpu: $cpuName");
    AppLogger().i("gpu: $gpuName");
    AppLogger().i("ramSize: $ramSize()");
  }

  // ---------------     json     ---------------
  Future<Map<String, dynamic>> readJsonFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('File not found at $filePath');
      }
      
      final contents = await file.readAsString();
      if (contents.isEmpty) {
        throw Exception('File is empty');
      }
      
      return jsonDecode(contents) as Map<String, dynamic>;
    } on FormatException catch (e) {
      throw Exception('Invalid JSON format: ${e.message}');
    } catch (e) {
      throw Exception('Failed to read JSON file: $e');
    }
  }

  // get init
  Future<void> initialize() async {
    await readHWSpecs();
    await readLocalAppJson();
    await readGlobalAppJson();
  } 


}