// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'Log.model.dart';

class LoggerUtil {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/log.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return "";
    }
  }

  Future<File> writeLog(String message) async {
    final file = await localFile;

    List<LogModel> logsList = [];

    LogModel logModel = LogModel(
      message,
    );

    String logs = await readData();

    try {
      logsList = (json.decode(logs) as List)
          .map((data) => LogModel.fromJson(data))
          .toList();
    } catch (e) {
      logsList = [];
    }

    if (logsList.isNotEmpty) {
      logsList.add(logModel);
      String json = jsonEncode(logsList);
      file.writeAsString(json);
    } else {
      List<LogModel> logsList = [];
      logsList.add(logModel);

      String json = jsonEncode(logsList);

      file.writeAsStringSync(json, mode: FileMode.append);
    }

    return file;
  }

  Future<int> getSizeLogs() async {
    String logs = await readData();

    List<LogModel> logsList = [];

    try {
      logsList = (json.decode(logs) as List)
          .map((data) => LogModel.fromJson(data))
          .toList();
    } catch (e) {
      logsList = [];
    }

    return logsList.length;
  }
}
