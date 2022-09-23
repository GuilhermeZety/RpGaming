// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'LogException.model.dart';
import 'StackTrace.model.dart';

class LoggerExceptionUtil {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/sync.json');
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

  String _getDateNow() {
    DateFormat format = DateFormat('dd-MM-yyyy HH:mm');
    String datetTimeNow = format.format(DateTime.now());
    return datetTimeNow;
  }

  Future<File> writeException(Object? exception, StackTrace? stackTrace) async {
    final file = await localFile;

    List<LogExeptionModel> logsExceptionList = [];

    StackTraceModel stackTraceCurrent = StackTraceModel(stackTrace!);

    LogExeptionModel logModel = LogExeptionModel(
        _getDateNow(),
        exception.toString(),
        stackTraceCurrent.fileName,
        stackTraceCurrent.lineNumber,
        stackTraceCurrent.columnNumber);

    String logs = await readData();

    try {
      logsExceptionList = (json.decode(logs) as List)
          .map((data) => LogExeptionModel.fromJson(data))
          .toList();
      //logsExceptionList = (jsonDecode(logs) as List<String>).cast<LogModel>();
    } catch (e) {
      logsExceptionList = [];
    }
    //Verifica se tem alguma lista de logs dentro do arquivo
    if (logsExceptionList.isNotEmpty) {
      logsExceptionList.add(logModel);
      String json = jsonEncode(logsExceptionList);
      file.writeAsString(json);
    } else {
      /* Adiciona primeiro log no arquivo */
      List<LogExeptionModel> logsList = [];
      logsList.add(logModel);

      String json = jsonEncode(logsList);

      file.writeAsStringSync(json, mode: FileMode.append);
    }

    return file;
  }

  Future<int> getSizeLogException() async {
    String logs = await readData();

    List<LogExeptionModel> logsExceptionList = [];

    try {
      logsExceptionList = (json.decode(logs) as List)
          .map((data) => LogExeptionModel.fromJson(data))
          .toList();
    } catch (e) {
      logsExceptionList = [];
    }

    return logsExceptionList.length;
  }
}
