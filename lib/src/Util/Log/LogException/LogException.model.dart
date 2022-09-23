class LogExeptionModel {
  String data;
  String exception;
  String fileName;
  int lineNumber = 0;
  int columnNumber = 0;

  LogExeptionModel(this.data, this.exception, this.fileName, this.lineNumber,
      this.columnNumber);

  LogExeptionModel.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        exception = json['exception'],
        fileName = json['fileName'],
        lineNumber = json['lineNumber'],
        columnNumber = json['columnNumber'];

  Map<String, dynamic> toJson() => {
        'data': data,
        'exception': exception,
        'fileName': fileName,
        'lineNumber': lineNumber,
        'columnNumber': columnNumber
      };
}
