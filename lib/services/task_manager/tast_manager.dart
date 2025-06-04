import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tester/config.dart';
import 'package:tester/logger_wrapper.dart';
import 'package:tester/services/task_manager/task.dart';


class TaskManager{
  final _taskQueue = <Task>[];
  bool _isRunning = false;

  final _progressController = StreamController<String>.broadcast();
  Stream<String> get progressStream => _progressController.stream;

  void _addTask(Task task){
    _taskQueue.add(task);
    _startNext();
  }
  void _startNext()
  {
    if (_isRunning || _taskQueue.isEmpty)
    {
      return;
    }

    _isRunning = true;
    final task = _taskQueue.removeAt(0);
    _handleTask(task).then((_) {
      _isRunning = false;
      _startNext();
    });
  }

  Future<void> _handleTask(Task task) async {
      final file = File(task.path);
      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }

      final request = http.Request('GET', Uri.parse(task.url));
      final response = await request.send();

      if (response.statusCode != 200) {
        AppLogger().w("Error while download file $task.path");
      }

      final contentLength = response.contentLength ?? 0;

      int bytesReceived = 0;

      final sink = file.openWrite();
      await response.stream.listen(
        (chunk) {
          bytesReceived += chunk.length;
          sink.add(chunk);
          final progress = (bytesReceived/contentLength * 100).toStringAsFixed(1);
          AppLogger().i('Downloading $task.url: $progress%');
        },
        onDone: () async {
          await sink.close();
          AppLogger().i('Downloaded $task.url, to $task.path');
        },
        onError: (ec) async {
          await sink.close();
          throw Exception("error while downloading $task.url: $ec");
        },
        cancelOnError: true,
      ).asFuture();
  }

  void dispose() {
    _progressController.close();
  }
}