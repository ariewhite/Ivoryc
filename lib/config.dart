import 'dart:io';

class AppConfig 
{
  static final AppConfig _instance = AppConfig._internal();

  AppConfig._internal();

  static AppConfig get instance => _instance;



  // --------------- hardware specs ---------------
  late int? ramSizeBytes; // ram size in bytes
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

  // --------------- getters     ---------------

  int? getRamSizeBytes() => ramSizeBytes;
  double? getRamSizeGB()
  {
    if (ramSizeBytes != null && ramSizeBytes != 0)
    {
      return ramSizeBytes!/(1024*1024*1024);
    } else {
      return 0;
    }
  }
  String? getCpuName() => cpuName;
  String? getGpuName() => gpuName;


  // --------------- other methods ---------------
  Future<void> readHWSpecs() async
  {
    cpuName = await readCpuName();
    gpuName = await readGpuName();
    ramSizeBytes = await readRam();
  }


}