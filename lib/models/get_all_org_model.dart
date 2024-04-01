// To parse this JSON data, do
//
//     final getAllOrgModel = getAllOrgModelFromJson(jsonString);

import 'dart:convert';

List<GetAllOrgModel> getAllOrgModelFromJson(String str) =>
    List<GetAllOrgModel>.from(
        json.decode(str).map((x) => GetAllOrgModel.fromJson(x)));

String getAllOrgModelToJson(List<GetAllOrgModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllOrgModel {
  int? pk;
  String? companyName;
  String? add1;
  String? add2;
  String? contactNo;
  String? email;
  dynamic gstNo;

  GetAllOrgModel({
    this.pk,
    this.companyName,
    this.add1,
    this.add2,
    this.contactNo,
    this.email,
    this.gstNo,
  });

  factory GetAllOrgModel.fromJson(Map<String, dynamic> json) => GetAllOrgModel(
        pk: json["pk"],
        companyName: json["company_name"],
        add1: json["add_1"],
        add2: json["add_2"],
        contactNo: json["contact_no"],
        email: json["email"],
        gstNo: json["gst_no"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "company_name": companyName,
        "add_1": add1,
        "add_2": add2,
        "contact_no": contactNo,
        "email": email,
        "gst_no": gstNo,
      };
}
