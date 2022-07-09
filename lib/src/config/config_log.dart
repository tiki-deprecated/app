/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'config_sentry.dart';

class ConfigLog {

  Future<void> init() async {
    Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
    Logger.root.onRecord.listen(onRecord);
    await _rotateLog();
  }

  Future<void> onRecord(LogRecord record) async {
    if (kDebugMode) {
      print(logMessage(record));
    } else {
      if (record.level >= Level.INFO) {
        await _writeLogFile("${logMessage(record)} - ${record.error.toString()}");
        if (record.level >= Level.SEVERE) {
          ConfigSentry.exception(record.message, stackTrace: record.stackTrace);
        } else if (record.level >= Level.WARNING) {
          ConfigSentry.message(record.message,
              level: _toSentryLevel(record.level),
              params: [record.loggerName, record.error, record.stackTrace]);
        }
      }
    }
  }

  String _formatTime(DateTime timestamp) {
    return "${timestamp.day.toString().padLeft(2, '0')}/"
        "${timestamp.month.toString().padLeft(2, '0')}/"
        "${timestamp.year.toString().replaceRange(0, 2, '')} "
        "${timestamp.hour.toString().padLeft(2, '0')}:"
        "${timestamp.minute.toString().padLeft(2, '0')}:"
        "${timestamp.second.toString().padLeft(2, '0')}."
        "${timestamp.millisecond.toString().padRight(3, '0')}";
  }

  SentryLevel _toSentryLevel(Level level) {
    if (level == Level.FINEST || level == Level.FINER || level == Level.FINE) {
      return ConfigSentry.levelDebug;
    } else if (level == Level.WARNING) {
      return ConfigSentry.levelWarn;
    } else if (level == Level.SEVERE) {
      return ConfigSentry.levelError;
    } else if (level == Level.SHOUT) {
      return ConfigSentry.levelFatal;
    } else {
      return ConfigSentry.levelInfo;
    }
  }

  String logMessage(LogRecord record) =>
      "${_formatTime(record.time)}: ${record.level.name} "
          "[${record.loggerName}] ${record.message}";

  Future<void> _writeLogFile(String log) async {
    String path = await _logPath;
    String filename = _logFileName;
    File file = File('$path/$filename');
    file.writeAsStringSync("$log\n", mode: FileMode.append);
  }

  Future<String> get _logPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  String get _logFileName {
    DateTime now = DateTime.now();
    return "${now.year.toString()}${now.month.toString().padLeft(2, '0')}${
      now.day.toString().padLeft(2, '0')}.log";
  }

  int get _rotateDate {
    DateTime now = DateTime.now().subtract(const Duration(days: 15));
    return int.parse("${now.year.toString()}${now.month.toString().padLeft(2, '0')}${
        now.day.toString().padLeft(2, '0')}");
  }

  Future<void> _rotateLog() async{
    String path = await _logPath;
    Directory dir = Directory(path);
    List<File> files = (await dir.list().toList()).whereType<File>().toList();
    for (File file in files) {
      if(file.path.endsWith('log')){
        String filename = file.path.split(Platform.pathSeparator).last;
        if(filename == _logFileName && file.lengthSync() > 1000000){
          String newPath = "$path${Platform.pathSeparator}$filename.1";
          await file.rename(newPath);
          continue;
        }
        int fileDate = int.parse(filename.replaceFirst(".log.1", "").replaceFirst(".log", ""));
        if(fileDate < _rotateDate){
          await file.delete();
        }
      }
    }
  }
}
