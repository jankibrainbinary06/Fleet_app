// To parse this JSON data, do
//
//     final updateTransactionModel = updateTransactionModelFromJson(jsonString);

import 'dart:convert';

UpdateTransactionModel updateTransactionModelFromJson(String str) =>
    UpdateTransactionModel.fromJson(json.decode(str));

String updateTransactionModelToJson(UpdateTransactionModel data) =>
    json.encode(data.toJson());

class UpdateTransactionModel {
  TransactionDetails? transactionDetails;
  String? message;

  UpdateTransactionModel({
    this.transactionDetails,
    this.message,
  });

  factory UpdateTransactionModel.fromJson(Map<String, dynamic> json) =>
      UpdateTransactionModel(
        transactionDetails: json["TransactionDetails"] == null
            ? null
            : TransactionDetails.fromJson(json["TransactionDetails"]),
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "TransactionDetails": transactionDetails?.toJson(),
        "Message": message,
      };
}

class TransactionDetails {
  int? outgoingPk;
  String? companyName;

  TransactionDetails({
    this.outgoingPk,
    this.companyName,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        outgoingPk: json["outgoing_pk"],
        companyName: json["CompanyName"],
      );

  Map<String, dynamic> toJson() => {
        "outgoing_pk": outgoingPk,
        "CompanyName": companyName,
      };
}
