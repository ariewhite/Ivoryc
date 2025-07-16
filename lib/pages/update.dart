import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tester/config.dart';
// import 'package:tester/services/task_manager/tast_manager.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:tester/configs/styles/decoration/app_decoration.dart';
import 'package:tester/configs/styles/text_styles/app_text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tester/profile/mini_profile.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final ValueNotifier<int> downloadNotifier = ValueNotifier(0);
  final ValueNotifier<String> currentFile = ValueNotifier("Downloading sample.zip");
  final TextEditingController _pathController = TextEditingController();
  final String data = "## Version 1.0.1 ######\n"
                      "Changes: \n"
                      "- New mods added to this great path \n"
                      "- New core\n"
                      "- New life\n"
                      "- Loh\n";

  @override
  void dispose() {
    downloadNotifier.dispose();
    super.dispose();
  }

  void downloadLibs() async {
    MinecraftDownloader md = MinecraftDownloader();
    await md.downloadVersion(folderName: "instance");
  }

  Future<void> downloadFileFromServer() async {
    downloadNotifier.value = 0;
    Directory directory = Directory("");
    if (Platform.isWindows) {
      directory = await getApplicationDocumentsDirectory();
    }

    await Dio().download(
      "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_30mb.mp4",
      "${directory.path}/video.mp4",
      onReceiveProgress: (actualBytes, totalBytes) {
        downloadNotifier.value = (actualBytes / totalBytes * 100).floor();
        currentFile.value = "Downloading sample.zip";
      },
    );

    print('File downloaded at ${directory.path}/video.mp4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),
          Positioned(
            right: 25,
            top: 25,
            child: MiniProfile(
              hours: 2,
              minutes: 20,
              nick: AppConfig.instance.nickname,
            ),
          ),

          // version frame
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 100.0, 100.0, 600.0),
              child: Row(
                children: [
                  Container(color: Colors.white, width: 2),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Versions:", style: AppTextStyles.h2whiteInter()),
                      const SizedBox(height: 10),
                      Text(
                        "Local: ${AppConfig.instance.appVersion}\nGlobal: ${AppConfig.instance.gAppVersion}",
                        style: AppTextStyles.updateVersion(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // update frame
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 50.0, 0, 0),
              child: Container(
                // color: Colors.black12,
                width: 550,
                height: 100,
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsetsGeometry.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: ValueListenableBuilder<int>(
                        valueListenable: downloadNotifier,
                        builder: (context, value, _) {
                          return LinearPercentIndicator(
                            barRadius: const Radius.circular(12.0),
                            lineHeight: 5.0,
                            width: 530.0,
                            percent: value / 100,
                            backgroundColor: Colors.white,
                            progressColor: Colors.indigoAccent,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 2),
                    // percent text
                    Align(
                      alignment: const Alignment(0.88, 0.0),
                      child: ValueListenableBuilder<int>(
                        valueListenable: downloadNotifier,
                        builder: (context, value, _) => Text("$value%",
                            style: AppTextStyles.updateVersion()
                            ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.0, 0.0),
                      child: ValueListenableBuilder<String>(
                        valueListenable: currentFile,
                        builder: (context, value, _) => Text(
                          value,
                          style: AppTextStyles.updateVersion()
                          ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // pathnote frame
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsetsGeometry.fromLTRB(0.0, 100.0, 20.0, 0.0),
              child: Container(
                color: Colors.black12,
                alignment: Alignment.topLeft,
                width: 650,
                height: 350,
                child: Row(
                  children: [
                    // slider
                    Container(
                      color: Colors.white,
                      width: 2,
                    ), 
                    const SizedBox(
                      width: 10.0,
                      height: 0.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pathnote", style: AppTextStyles.h2whiteInter()),
                          const SizedBox(height: 5.0),
                          Expanded(
                            child: MarkdownParse(
                              data: data,
                              styleSheet: AppMarkdownStyles.defaultStyle(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // update button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 115.0),
              child:  ElevatedButton(
              onPressed: downloadFileFromServer, 
              child: Text(
                "sample",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sf-pro',
                  fontSize:  14.5,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1.0,
                ),
                ),
              style: AppDecoration.elevated.transparent(),
              ),
            )
          )



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
