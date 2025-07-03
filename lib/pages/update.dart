import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tester/config.dart';
// import 'package:tester/services/task_manager/tast_manager.dart';

import 'package:tester/configs/styles/text_styles/app_text_styles.dart';

class Update extends StatelessWidget {
  const Update({super.key});

  void downloadLibs() async {
    MinecraftDownloader md = MinecraftDownloader();
    await md.downloadVersion(folderName: "instance");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg3.jpg', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Update Center",
                      style: AppTextStyles.h2white()
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 88.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Text("AppVersion local: ${AppConfig.instance.appVersion}",
                        style: AppTextStyles.updateVersion(),
                        textAlign: TextAlign.left,
                        ),
                    Text("AppVersion global: ${AppConfig.instance.gAppVersion}",
                        style: AppTextStyles.updateVersion(),
                        textAlign: TextAlign.left,
                        )
                  ],
              ),
            )
          ),
        ],
      ),
    );
  }
}

// TODO: update this shit
// 1. parse manifest
// 2. update list of versions
// 3. update ui and let to user select version
// ps. but rn i ll realize download manager only for custom .minecraft
class MinecraftDownloader {
  final String manifestUrl =
      "https://piston-meta.mojang.com/mc/game/version_manifest_v2.json";

  Future<void> downloadVersion({required String folderName}) async {
    print("start download");
    // dir
    final dir = await getApplicationDocumentsDirectory();
    final targetDir = Directory(path.join(dir.path, folderName));
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final manifest = await _fetchJson(manifestUrl);
    final versionId = AppConfig.instance.minecraftVersion;
    final versionMeta =
        manifest['versions'].firstWhere((v) => v['id'] == versionId);

    final versionJson = await _fetchJson(versionMeta['url']);
    final client = versionJson['downloads']['client'];

    await _downloadFile(
        client['url'], path.join(targetDir.path, '$versionId.jar'));

    final libraries = versionJson['libraries'];
    for (var lib in libraries) {
      if (lib.containsKey('downloads') &&
          lib['downloads'].containsKey('artifact')) {
        final artifact = lib['downloads']['artifact'];
        final libPath =
            path.join(targetDir.path, 'libraries', artifact['path']);
        await _downloadFile(artifact['url'], libPath);
      }
    }
  }

  Future<Map<String, dynamic>> _fetchJson(String url) async {
    final message = await http.get(Uri.parse(url));
    if (message.statusCode != 200)
      throw Exception("Error while fetching json $url");
    return jsonDecode(message.body);
  }

  Future<void> _downloadFile(String url, String outPath) async {
    final file = File(outPath);
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    final request = http.Request('GET', Uri.parse(url));
    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("error while download $url");
    }

    final contentLength = response.contentLength ?? 0;

    int bytesReceived = 0;

    final sink = file.openWrite();
    await response.stream.listen(
      (chunk) {
        bytesReceived += chunk.length;
        sink.add(chunk);
        final progress =
            (bytesReceived / contentLength * 100).toStringAsFixed(1);
        debugPrint('Downloading $url: $progress%');
      },
      onDone: () async {
        await sink.close();
        debugPrint("Downloaded $url to $outPath");
      },
      onError: (ec) async {
        await sink.close();
        throw Exception("error while downloading $url: $ec");
      },
      cancelOnError: true,
    ).asFuture();
  }
}
