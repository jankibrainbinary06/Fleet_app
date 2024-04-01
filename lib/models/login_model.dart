import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? token;
  String? message;

  LoginModel({
    this.token,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "Message": message,
      };
}
