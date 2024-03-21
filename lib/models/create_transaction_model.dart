import 'dart:convert';

CreateTransactionModel createTransactionModelFromJson(String str) =>
    CreateTransactionModel.fromJson(json.decode(str));

String createTransactionModelToJson(CreateTransactionModel data) =>
    json.encode(data.toJson());

class CreateTransactionModel {
  TransactionDetails? transactionDetails;
  String? message;

  CreateTransactionModel({
    this.transactionDetails,
    this.message,
  });

  factory CreateTransactionModel.fromJson(Map<String, dynamic> json) =>
      CreateTransactionModel(
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
