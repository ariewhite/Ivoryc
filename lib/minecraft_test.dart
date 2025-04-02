import 'dart:io';
import 'dart:convert';
// import 'package:path_provider/path_provider.dart';


import 'package:flutter/rendering.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

Future<void> getManifest() async
{
  const String manifestUrl = "https://piston-meta.mojang.com/mc/game/version_manifest_v2.json";

  final manifestResponse = await HttpClient().getUrl(Uri.parse(manifestUrl));
    final manifest = await manifestResponse.close();
    final manifestJson = jsonDecode(await manifest.transform(utf8.decoder).join());

    final latestVersionId = manifestJson["latest"]["release"];
    print("Последняя версия: $latestVersionId");

    final latestVersion = manifestJson["versions"].firstWhere((v) => v["id"] == latestVersionId);
    final versionUrl = latestVersion["url"];

    print("Version url: $versionUrl");

    final versionResponse = await HttpClient().getUrl(Uri.parse(versionUrl));
    final version = await versionResponse.close();
    final versionJson = jsonDecode(await version.transform(utf8.decoder).join());

    final clientJarUrl = versionJson["downloads"]["client"]["url"];
    final clientHashSum= versionJson["downloads"]["client"]["sha1"];
    final clientSize   = versionJson["downloads"]["client"]["size"];

    print("Client jar url: $clientJarUrl,\n hash sum: $clientHashSum, size: $clientSize");

    final file = File("minecraft_client_jar_${latestVersionId}.jar");
    final clientResponse =  await HttpClient().getUrl(Uri.parse(clientJarUrl));
    final clientFile = await clientResponse.close();
    final sink = file.openWrite();
    await clientFile.pipe(sink);
    await sink.close();

    print("Done!");
}

// void test()
// {
//   final dir = await getApplicationDocumentsDirectory();
//   print('${dir.path}/config.json');
// }


void main() async 
{
  // getManifest();
  // test();
}