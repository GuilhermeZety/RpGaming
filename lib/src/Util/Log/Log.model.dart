class LogModel {
  String message;

  LogModel(this.message);

  LogModel.fromJson(Map<String, dynamic> json) : message = json['message'];

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
