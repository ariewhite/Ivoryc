import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';


class AppLogger {
  static final AppLogger _instance = AppLogger._internal();

  factory AppLogger() => _instance;
  
  late Logger _logger;
  late File   _logFile;

  AppLogger._internal();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _logFile = File('${dir.path}/log.log');
    debugPrint('log path: $_logFile');

    if (!await _logFile.exists()) {
      await _logFile.create(recursive: true);
    }
    
    _logger = Logger(
      printer: SimplePrinter(),
      output: CombinedOutput(logFile: _logFile),
    );
  }

  void i(String msg) => _logger.i(msg);
  void w(String msg) => _logger.w(msg);
  void e(String msg) => _logger.e(msg);
  void d(String msg) => _logger.d(msg);
  void log(Level level, dynamic message) => _logger.log(level, message);

  File getLogFile() => _logFile;
}

class CombinedOutput extends LogOutput {
  final File logFile;

  CombinedOutput({required this.logFile});

  @override
  void output(OutputEvent event) {
    final fileSink = logFile.openWrite(mode: FileMode.append);

    for (var line in event.lines) {      
      stdout.writeln(line);
      fileSink.writeln(line);
    }

    fileSink.close();
  }
}

