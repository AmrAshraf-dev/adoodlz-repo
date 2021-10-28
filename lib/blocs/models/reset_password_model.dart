class ResetPasswordModel {
  var sent;
  var id;
  var message;
  var token;

  ResetPasswordModel({this.sent, this.id, this.message, this.token});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    sent = json['sent'];
    id = json['id'];
    message = json['message'];
    token = json['token'];
  }
}
