// To parse this JSON data, do
//
//     final markedVerifiedModel = markedVerifiedModelFromJson(jsonString);

import 'dart:convert';

MarkedVerifiedModel markedVerifiedModelFromJson(String str) =>
    MarkedVerifiedModel.fromJson(json.decode(str));

String markedVerifiedModelToJson(MarkedVerifiedModel data) =>
    json.encode(data.toJson());

class MarkedVerifiedModel {
  String? message;

  MarkedVerifiedModel({
    this.message,
  });

  factory MarkedVerifiedModel.fromJson(Map<String, dynamic> json) =>
      MarkedVerifiedModel(
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
      };
}
