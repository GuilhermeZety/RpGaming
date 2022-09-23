class StackTraceModel {
  final StackTrace _trace;

  String fileName = '';
  int lineNumber = 0;
  int columnNumber = 0;

  StackTraceModel(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = _trace.toString().split("\n")[0];

    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z]+.dart'));

    var fileInfo = traceString.substring(indexOfFileName);

    var listOfInfos = fileInfo.split(":");

    fileName = listOfInfos[0];
    lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    columnNumber = int.parse(columnStr);
  }
}
