// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseModel {
  String message;
  bool success;
  bool isError;
  bool isWarning;
  var data; 

  ResponseModel({
    required this.message,
    this.success = false,
    this.isError = false,
    this.isWarning = false,
    this.data,
  });

  ResponseModel copyWith({
    String? message,
    bool? success,
    bool? isError,
    bool? isWarning,
    var data,
  }) {
    return ResponseModel(
      message: message ?? this.message,
      success: success ?? this.success,
      isError: isError ?? this.isError,
      isWarning: isWarning ?? this.isWarning,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'success': success,
      'isError': isError,
      'isWarning': isWarning,
      'data': data.toMap(),
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      message: map['message'] as String,
      success: map['success'] as bool,
      isError: map['isError'] as bool,
      isWarning: map['isWarning'] as bool,
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) => ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseModel(message: $message, success: $success, isError: $isError, isWarning: $isWarning, data: $data)';
  }

  @override
  bool operator ==(covariant ResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.success == success &&
      other.isError == isError &&
      other.isWarning == isWarning &&
      other.data == data;
  }

  @override
  int get hashCode {
    return message.hashCode ^
      success.hashCode ^
      isError.hashCode ^
      isWarning.hashCode ^
      data.hashCode;
  }
}
