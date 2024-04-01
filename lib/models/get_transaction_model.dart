//
//
// import 'dart:convert';
//
// List<GetTransactionModel> getTransactionModelFromJson(String str) => List<GetTransactionModel>.from(json.decode(str).map((x) => GetTransactionModel.fromJson(x)));
//
// String getTransactionModelToJson(List<GetTransactionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class GetTransactionModel {
//   int? id;
//   VehicleDetails? vehicleDetails;
//   String? l1;
//   bool? l1Verified;
//   String? l1VerifiedImage;
//   String? l1Barcode;
//   String? l2;
//   bool? l2Verified;
//   String? l2VerifiedImage;
//   String? l2Barcode;
//   String? l3;
//   bool? l3Verified;
//   String? l3VerifiedImage;
//   dynamic l3Barcode;
//   String? l4;
//   bool? l4Verified;
//   String? l4VerifiedImage;
//   dynamic l4Barcode;
//   String? l5;
//   bool? l5Verified;
//   String? l5VerifiedImage;
//   dynamic l5Barcode;
//   String? r1;
//   bool? r1Verified;
//   String? r1VerifiedImage;
//   dynamic r1Barcode;
//   String? r2;
//   bool? r2Verified;
//   String? r2VerifiedImage;
//   dynamic r2Barcode;
//   String? r3;
//   bool? r3Verified;
//   String? r3VerifiedImage;
//   dynamic r3Barcode;
//   String? r4;
//   bool? r4Verified;
//   String? r4VerifiedImage;
//   dynamic r4Barcode;
//   String? r5;
//   bool? r5Verified;
//   String? r5VerifiedImage;
//   dynamic r5Barcode;
//   String? f1;
//   bool? f1Verified;
//   String? f1VerifiedImage;
//   dynamic f1Barcode;
//   String? f2;
//   bool? f2Verified;
//   String? f2VerifiedImage;
//   dynamic f2Barcode;
//   String? b1;
//   bool? b1Verified;
//   String? b1VerifiedImage;
//   dynamic b1Barcode;
//   String? b2;
//   bool? b2Verified;
//   String? b2VerifiedImage;
//   dynamic b2Barcode;
//   String? dp1;
//   bool? dp1Verified;
//   String? dp1VerifiedImage;
//   dynamic dp1Barcode;
//   String? dp2;
//   bool? dp2Verified;
//   String? dp2VerifiedImage;
//   dynamic dp2Barcode;
//   String? mp1;
//   bool? mp1Verified;
//   String? mp1VerifiedImage;
//   dynamic mp1Barcode;
//   String? mp2;
//   bool? mp2Verified;
//   String? mp2VerifiedImage;
//   dynamic mp2Barcode;
//   String? mp3;
//   bool? mp3Verified;
//   String? mp3VerifiedImage;
//   dynamic mp3Barcode;
//   String? mp4;
//   bool? mp4Verified;
//   String? mp4VerifiedImage;
//   dynamic mp4Barcode;
//   String? mp5;
//   bool? mp5Verified;
//   String? mp5VerifiedImage;
//   dynamic mp5Barcode;
//   String? mp6;
//   bool? mp6Verified;
//   String? mp6VerifiedImage;
//   dynamic mp6Barcode;
//   String? mp7;
//   bool? mp7Verified;
//   String? mp7VerifiedImage;
//   dynamic mp7Barcode;
//   String? mp8;
//   bool? mp8Verified;
//   String? mp8VerifiedImage;
//   dynamic mp8Barcode;
//   bool? vehicleInwardComplete;
//   DateTime? createdOn;
//   int? organisation;
//   int? vehicle;
//   int? createdBy;
//
//   GetTransactionModel({
//     this.id,
//     this.vehicleDetails,
//     this.l1,
//     this.l1Verified,
//     this.l1VerifiedImage,
//     this.l1Barcode,
//     this.l2,
//     this.l2Verified,
//     this.l2VerifiedImage,
//     this.l2Barcode,
//     this.l3,
//     this.l3Verified,
//     this.l3VerifiedImage,
//     this.l3Barcode,
//     this.l4,
//     this.l4Verified,
//     this.l4VerifiedImage,
//     this.l4Barcode,
//     this.l5,
//     this.l5Verified,
//     this.l5VerifiedImage,
//     this.l5Barcode,
//     this.r1,
//     this.r1Verified,
//     this.r1VerifiedImage,
//     this.r1Barcode,
//     this.r2,
//     this.r2Verified,
//     this.r2VerifiedImage,
//     this.r2Barcode,
//     this.r3,
//     this.r3Verified,
//     this.r3VerifiedImage,
//     this.r3Barcode,
//     this.r4,
//     this.r4Verified,
//     this.r4VerifiedImage,
//     this.r4Barcode,
//     this.r5,
//     this.r5Verified,
//     this.r5VerifiedImage,
//     this.r5Barcode,
//     this.f1,
//     this.f1Verified,
//     this.f1VerifiedImage,
//     this.f1Barcode,
//     this.f2,
//     this.f2Verified,
//     this.f2VerifiedImage,
//     this.f2Barcode,
//     this.b1,
//     this.b1Verified,
//     this.b1VerifiedImage,
//     this.b1Barcode,
//     this.b2,
//     this.b2Verified,
//     this.b2VerifiedImage,
//     this.b2Barcode,
//     this.dp1,
//     this.dp1Verified,
//     this.dp1VerifiedImage,
//     this.dp1Barcode,
//     this.dp2,
//     this.dp2Verified,
//     this.dp2VerifiedImage,
//     this.dp2Barcode,
//     this.mp1,
//     this.mp1Verified,
//     this.mp1VerifiedImage,
//     this.mp1Barcode,
//     this.mp2,
//     this.mp2Verified,
//     this.mp2VerifiedImage,
//     this.mp2Barcode,
//     this.mp3,
//     this.mp3Verified,
//     this.mp3VerifiedImage,
//     this.mp3Barcode,
//     this.mp4,
//     this.mp4Verified,
//     this.mp4VerifiedImage,
//     this.mp4Barcode,
//     this.mp5,
//     this.mp5Verified,
//     this.mp5VerifiedImage,
//     this.mp5Barcode,
//     this.mp6,
//     this.mp6Verified,
//     this.mp6VerifiedImage,
//     this.mp6Barcode,
//     this.mp7,
//     this.mp7Verified,
//     this.mp7VerifiedImage,
//     this.mp7Barcode,
//     this.mp8,
//     this.mp8Verified,
//     this.mp8VerifiedImage,
//     this.mp8Barcode,
//     this.vehicleInwardComplete,
//     this.createdOn,
//     this.organisation,
//     this.vehicle,
//     this.createdBy,
//   });
//
//   factory GetTransactionModel.fromJson(Map<String, dynamic> json) => GetTransactionModel(
//     id: json["id"],
//     vehicleDetails: json["vehicle_details"] == null ? null : VehicleDetails.fromJson(json["vehicle_details"]),
//     l1: json["l1"],
//     l1Verified: json["l1_verified"],
//     l1VerifiedImage: json["l1_verified_image"],
//     l1Barcode: json["l1_barcode"],
//     l2: json["l2"],
//     l2Verified: json["l2_verified"],
//     l2VerifiedImage: json["l2_verified_image"],
//     l2Barcode: json["l2_barcode"],
//     l3: json["l3"],
//     l3Verified: json["l3_verified"],
//     l3VerifiedImage: json["l3_verified_image"],
//     l3Barcode: json["l3_barcode"],
//     l4: json["l4"],
//     l4Verified: json["l4_verified"],
//     l4VerifiedImage: json["l4_verified_image"],
//     l4Barcode: json["l4_barcode"],
//     l5: json["l5"],
//     l5Verified: json["l5_verified"],
//     l5VerifiedImage: json["l5_verified_image"],
//     l5Barcode: json["l5_barcode"],
//     r1: json["r1"],
//     r1Verified: json["r1_verified"],
//     r1VerifiedImage: json["r1_verified_image"],
//     r1Barcode: json["r1_barcode"],
//     r2: json["r2"],
//     r2Verified: json["r2_verified"],
//     r2VerifiedImage: json["r2_verified_image"],
//     r2Barcode: json["r2_barcode"],
//     r3: json["r3"],
//     r3Verified: json["r3_verified"],
//     r3VerifiedImage: json["r3_verified_image"],
//     r3Barcode: json["r3_barcode"],
//     r4: json["r4"],
//     r4Verified: json["r4_verified"],
//     r4VerifiedImage: json["r4_verified_image"],
//     r4Barcode: json["r4_barcode"],
//     r5: json["r5"],
//     r5Verified: json["r5_verified"],
//     r5VerifiedImage: json["r5_verified_image"],
//     r5Barcode: json["r5_barcode"],
//     f1: json["f1"],
//     f1Verified: json["f1_verified"],
//     f1VerifiedImage: json["f1_verified_image"],
//     f1Barcode: json["f1_barcode"],
//     f2: json["f2"],
//     f2Verified: json["f2_verified"],
//     f2VerifiedImage: json["f2_verified_image"],
//     f2Barcode: json["f2_barcode"],
//     b1: json["b1"],
//     b1Verified: json["b1_verified"],
//     b1VerifiedImage: json["b1_verified_image"],
//     b1Barcode: json["b1_barcode"],
//     b2: json["b2"],
//     b2Verified: json["b2_verified"],
//     b2VerifiedImage: json["b2_verified_image"],
//     b2Barcode: json["b2_barcode"],
//     dp1: json["dp1"],
//     dp1Verified: json["dp1_verified"],
//     dp1VerifiedImage: json["dp1_verified_image"],
//     dp1Barcode: json["dp1_barcode"],
//     dp2: json["dp2"],
//     dp2Verified: json["dp2_verified"],
//     dp2VerifiedImage: json["dp2_verified_image"],
//     dp2Barcode: json["dp2_barcode"],
//     mp1: json["mp1"],
//     mp1Verified: json["mp1_verified"],
//     mp1VerifiedImage: json["mp1_verified_image"],
//     mp1Barcode: json["mp1_barcode"],
//     mp2: json["mp2"],
//     mp2Verified: json["mp2_verified"],
//     mp2VerifiedImage: json["mp2_verified_image"],
//     mp2Barcode: json["mp2_barcode"],
//     mp3: json["mp3"],
//     mp3Verified: json["mp3_verified"],
//     mp3VerifiedImage: json["mp3_verified_image"],
//     mp3Barcode: json["mp3_barcode"],
//     mp4: json["mp4"],
//     mp4Verified: json["mp4_verified"],
//     mp4VerifiedImage: json["mp4_verified_image"],
//     mp4Barcode: json["mp4_barcode"],
//     mp5: json["mp5"],
//     mp5Verified: json["mp5_verified"],
//     mp5VerifiedImage: json["mp5_verified_image"],
//     mp5Barcode: json["mp5_barcode"],
//     mp6: json["mp6"],
//     mp6Verified: json["mp6_verified"],
//     mp6VerifiedImage: json["mp6_verified_image"],
//     mp6Barcode: json["mp6_barcode"],
//     mp7: json["mp7"],
//     mp7Verified: json["mp7_verified"],
//     mp7VerifiedImage: json["mp7_verified_image"],
//     mp7Barcode: json["mp7_barcode"],
//     mp8: json["mp8"],
//     mp8Verified: json["mp8_verified"],
//     mp8VerifiedImage: json["mp8_verified_image"],
//     mp8Barcode: json["mp8_barcode"],
//     vehicleInwardComplete: json["vehicle_inward_complete"],
//     createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
//     organisation: json["organisation"],
//     vehicle: json["vehicle"],
//     createdBy: json["created_by"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "vehicle_details": vehicleDetails?.toJson(),
//     "l1": l1,
//     "l1_verified": l1Verified,
//     "l1_verified_image": l1VerifiedImage,
//     "l1_barcode": l1Barcode,
//     "l2": l2,
//     "l2_verified": l2Verified,
//     "l2_verified_image": l2VerifiedImage,
//     "l2_barcode": l2Barcode,
//     "l3": l3,
//     "l3_verified": l3Verified,
//     "l3_verified_image": l3VerifiedImage,
//     "l3_barcode": l3Barcode,
//     "l4": l4,
//     "l4_verified": l4Verified,
//     "l4_verified_image": l4VerifiedImage,
//     "l4_barcode": l4Barcode,
//     "l5": l5,
//     "l5_verified": l5Verified,
//     "l5_verified_image": l5VerifiedImage,
//     "l5_barcode": l5Barcode,
//     "r1": r1,
//     "r1_verified": r1Verified,
//     "r1_verified_image": r1VerifiedImage,
//     "r1_barcode": r1Barcode,
//     "r2": r2,
//     "r2_verified": r2Verified,
//     "r2_verified_image": r2VerifiedImage,
//     "r2_barcode": r2Barcode,
//     "r3": r3,
//     "r3_verified": r3Verified,
//     "r3_verified_image": r3VerifiedImage,
//     "r3_barcode": r3Barcode,
//     "r4": r4,
//     "r4_verified": r4Verified,
//     "r4_verified_image": r4VerifiedImage,
//     "r4_barcode": r4Barcode,
//     "r5": r5,
//     "r5_verified": r5Verified,
//     "r5_verified_image": r5VerifiedImage,
//     "r5_barcode": r5Barcode,
//     "f1": f1,
//     "f1_verified": f1Verified,
//     "f1_verified_image": f1VerifiedImage,
//     "f1_barcode": f1Barcode,
//     "f2": f2,
//     "f2_verified": f2Verified,
//     "f2_verified_image": f2VerifiedImage,
//     "f2_barcode": f2Barcode,
//     "b1": b1,
//     "b1_verified": b1Verified,
//     "b1_verified_image": b1VerifiedImage,
//     "b1_barcode": b1Barcode,
//     "b2": b2,
//     "b2_verified": b2Verified,
//     "b2_verified_image": b2VerifiedImage,
//     "b2_barcode": b2Barcode,
//     "dp1": dp1,
//     "dp1_verified": dp1Verified,
//     "dp1_verified_image": dp1VerifiedImage,
//     "dp1_barcode": dp1Barcode,
//     "dp2": dp2,
//     "dp2_verified": dp2Verified,
//     "dp2_verified_image": dp2VerifiedImage,
//     "dp2_barcode": dp2Barcode,
//     "mp1": mp1,
//     "mp1_verified": mp1Verified,
//     "mp1_verified_image": mp1VerifiedImage,
//     "mp1_barcode": mp1Barcode,
//     "mp2": mp2,
//     "mp2_verified": mp2Verified,
//     "mp2_verified_image": mp2VerifiedImage,
//     "mp2_barcode": mp2Barcode,
//     "mp3": mp3,
//     "mp3_verified": mp3Verified,
//     "mp3_verified_image": mp3VerifiedImage,
//     "mp3_barcode": mp3Barcode,
//     "mp4": mp4,
//     "mp4_verified": mp4Verified,
//     "mp4_verified_image": mp4VerifiedImage,
//     "mp4_barcode": mp4Barcode,
//     "mp5": mp5,
//     "mp5_verified": mp5Verified,
//     "mp5_verified_image": mp5VerifiedImage,
//     "mp5_barcode": mp5Barcode,
//     "mp6": mp6,
//     "mp6_verified": mp6Verified,
//     "mp6_verified_image": mp6VerifiedImage,
//     "mp6_barcode": mp6Barcode,
//     "mp7": mp7,
//     "mp7_verified": mp7Verified,
//     "mp7_verified_image": mp7VerifiedImage,
//     "mp7_barcode": mp7Barcode,
//     "mp8": mp8,
//     "mp8_verified": mp8Verified,
//     "mp8_verified_image": mp8VerifiedImage,
//     "mp8_barcode": mp8Barcode,
//     "vehicle_inward_complete": vehicleInwardComplete,
//     "created_on": createdOn?.toIso8601String(),
//     "organisation": organisation,
//     "vehicle": vehicle,
//     "created_by": createdBy,
//   };
// }
//
// class VehicleDetails {
//   int? pk;
//   String? vehicleNo;
//
//   VehicleDetails({
//     this.pk,
//     this.vehicleNo,
//   });
//
//   factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
//     pk: json["pk"],
//     vehicleNo: json["vehicle_no"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pk": pk,
//     "vehicle_no": vehicleNo,
//   };
// }
// To parse this JSON data, do
//
//     final getTransactionModel = getTransactionModelFromJson(jsonString);

import 'dart:convert';

List<GetTransactionModel> getTransactionModelFromJson(String str) => List<GetTransactionModel>.from(json.decode(str).map((x) => GetTransactionModel.fromJson(x)));

String getTransactionModelToJson(List<GetTransactionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTransactionModel {
  int? id;
  VehicleDetails? vehicleDetails;
  String? l1;
  bool? l1Verified;
  String? l1VerifiedImage;
  String? l1Qr;
  String? l1Barcode;
  String? l2;
  bool? l2Verified;
  String? l2VerifiedImage;
  String? l2Qr;
  String? l2Barcode;
  String? l3;
  bool? l3Verified;
  String? l3VerifiedImage;
  dynamic l3Qr;
  dynamic l3Barcode;
  String? l4;
  bool? l4Verified;
  String? l4VerifiedImage;
  dynamic l4Qr;
  dynamic l4Barcode;
  String? l5;
  bool? l5Verified;
  String? l5VerifiedImage;
  dynamic l5Qr;
  dynamic l5Barcode;
  String? r1;
  bool? r1Verified;
  String? r1VerifiedImage;
  dynamic r1Qr;
  dynamic r1Barcode;
  String? r2;
  bool? r2Verified;
  String? r2VerifiedImage;
  dynamic r2Qr;
  dynamic r2Barcode;
  String? r3;
  bool? r3Verified;
  String? r3VerifiedImage;
  dynamic r3Qr;
  dynamic r3Barcode;
  String? r4;
  bool? r4Verified;
  String? r4VerifiedImage;
  dynamic r4Qr;
  dynamic r4Barcode;
  String? r5;
  bool? r5Verified;
  String? r5VerifiedImage;
  dynamic r5Qr;
  dynamic r5Barcode;
  String? f1;
  bool? f1Verified;
  String? f1VerifiedImage;
  dynamic f1Qr;
  dynamic f1Barcode;
  String? f2;
  bool? f2Verified;
  String? f2VerifiedImage;
  dynamic f2Qr;
  dynamic f2Barcode;
  String? b1;
  bool? b1Verified;
  String? b1VerifiedImage;
  dynamic b1Qr;
  dynamic b1Barcode;
  String? b2;
  bool? b2Verified;
  String? b2VerifiedImage;
  dynamic b2Qr;
  dynamic b2Barcode;
  String? dp1;
  bool? dp1Verified;
  String? dp1VerifiedImage;
  String? dp1Qr;
  String? dp1Barcode;
  String? dp2;
  bool? dp2Verified;
  String? dp2VerifiedImage;
  dynamic dp2Qr;
  dynamic dp2Barcode;
  String? mp1;
  bool? mp1Verified;
  String? mp1VerifiedImage;
  dynamic mp1Qr;
  dynamic mp1Barcode;
  String? mp2;
  bool? mp2Verified;
  String? mp2VerifiedImage;
  dynamic mp2Qr;
  dynamic mp2Barcode;
  String? mp3;
  bool? mp3Verified;
  String? mp3VerifiedImage;
  dynamic mp3Qr;
  dynamic mp3Barcode;
  String? mp4;
  bool? mp4Verified;
  String? mp4VerifiedImage;
  dynamic mp4Qr;
  dynamic mp4Barcode;
  String? mp5;
  bool? mp5Verified;
  String? mp5VerifiedImage;
  dynamic mp5Qr;
  dynamic mp5Barcode;
  String? mp6;
  bool? mp6Verified;
  String? mp6VerifiedImage;
  dynamic mp6Qr;
  dynamic mp6Barcode;
  String? mp7;
  bool? mp7Verified;
  String? mp7VerifiedImage;
  dynamic mp7Qr;
  dynamic mp7Barcode;
  String? mp8;
  bool? mp8Verified;
  String? mp8VerifiedImage;
  dynamic mp8Qr;
  dynamic mp8Barcode;
  bool? vehicleInwardComplete;
  DateTime? createdOn;
  int? organisation;
  int? vehicle;
  int? createdBy;

  GetTransactionModel({
    this.id,
    this.vehicleDetails,
    this.l1,
    this.l1Verified,
    this.l1VerifiedImage,
    this.l1Qr,
    this.l1Barcode,
    this.l2,
    this.l2Verified,
    this.l2VerifiedImage,
    this.l2Qr,
    this.l2Barcode,
    this.l3,
    this.l3Verified,
    this.l3VerifiedImage,
    this.l3Qr,
    this.l3Barcode,
    this.l4,
    this.l4Verified,
    this.l4VerifiedImage,
    this.l4Qr,
    this.l4Barcode,
    this.l5,
    this.l5Verified,
    this.l5VerifiedImage,
    this.l5Qr,
    this.l5Barcode,
    this.r1,
    this.r1Verified,
    this.r1VerifiedImage,
    this.r1Qr,
    this.r1Barcode,
    this.r2,
    this.r2Verified,
    this.r2VerifiedImage,
    this.r2Qr,
    this.r2Barcode,
    this.r3,
    this.r3Verified,
    this.r3VerifiedImage,
    this.r3Qr,
    this.r3Barcode,
    this.r4,
    this.r4Verified,
    this.r4VerifiedImage,
    this.r4Qr,
    this.r4Barcode,
    this.r5,
    this.r5Verified,
    this.r5VerifiedImage,
    this.r5Qr,
    this.r5Barcode,
    this.f1,
    this.f1Verified,
    this.f1VerifiedImage,
    this.f1Qr,
    this.f1Barcode,
    this.f2,
    this.f2Verified,
    this.f2VerifiedImage,
    this.f2Qr,
    this.f2Barcode,
    this.b1,
    this.b1Verified,
    this.b1VerifiedImage,
    this.b1Qr,
    this.b1Barcode,
    this.b2,
    this.b2Verified,
    this.b2VerifiedImage,
    this.b2Qr,
    this.b2Barcode,
    this.dp1,
    this.dp1Verified,
    this.dp1VerifiedImage,
    this.dp1Qr,
    this.dp1Barcode,
    this.dp2,
    this.dp2Verified,
    this.dp2VerifiedImage,
    this.dp2Qr,
    this.dp2Barcode,
    this.mp1,
    this.mp1Verified,
    this.mp1VerifiedImage,
    this.mp1Qr,
    this.mp1Barcode,
    this.mp2,
    this.mp2Verified,
    this.mp2VerifiedImage,
    this.mp2Qr,
    this.mp2Barcode,
    this.mp3,
    this.mp3Verified,
    this.mp3VerifiedImage,
    this.mp3Qr,
    this.mp3Barcode,
    this.mp4,
    this.mp4Verified,
    this.mp4VerifiedImage,
    this.mp4Qr,
    this.mp4Barcode,
    this.mp5,
    this.mp5Verified,
    this.mp5VerifiedImage,
    this.mp5Qr,
    this.mp5Barcode,
    this.mp6,
    this.mp6Verified,
    this.mp6VerifiedImage,
    this.mp6Qr,
    this.mp6Barcode,
    this.mp7,
    this.mp7Verified,
    this.mp7VerifiedImage,
    this.mp7Qr,
    this.mp7Barcode,
    this.mp8,
    this.mp8Verified,
    this.mp8VerifiedImage,
    this.mp8Qr,
    this.mp8Barcode,
    this.vehicleInwardComplete,
    this.createdOn,
    this.organisation,
    this.vehicle,
    this.createdBy,
  });

  factory GetTransactionModel.fromJson(Map<String, dynamic> json) => GetTransactionModel(
    id: json["id"],
    vehicleDetails: json["vehicle_details"] == null ? null : VehicleDetails.fromJson(json["vehicle_details"]),
    l1: json["l1"],
    l1Verified: json["l1_verified"],
    l1VerifiedImage: json["l1_verified_image"],
    l1Qr: json["l1_qr"],
    l1Barcode: json["l1_barcode"],
    l2: json["l2"],
    l2Verified: json["l2_verified"],
    l2VerifiedImage: json["l2_verified_image"],
    l2Qr: json["l2_qr"],
    l2Barcode: json["l2_barcode"],
    l3: json["l3"],
    l3Verified: json["l3_verified"],
    l3VerifiedImage: json["l3_verified_image"],
    l3Qr: json["l3_qr"],
    l3Barcode: json["l3_barcode"],
    l4: json["l4"],
    l4Verified: json["l4_verified"],
    l4VerifiedImage: json["l4_verified_image"],
    l4Qr: json["l4_qr"],
    l4Barcode: json["l4_barcode"],
    l5: json["l5"],
    l5Verified: json["l5_verified"],
    l5VerifiedImage: json["l5_verified_image"],
    l5Qr: json["l5_qr"],
    l5Barcode: json["l5_barcode"],
    r1: json["r1"],
    r1Verified: json["r1_verified"],
    r1VerifiedImage: json["r1_verified_image"],
    r1Qr: json["r1_qr"],
    r1Barcode: json["r1_barcode"],
    r2: json["r2"],
    r2Verified: json["r2_verified"],
    r2VerifiedImage: json["r2_verified_image"],
    r2Qr: json["r2_qr"],
    r2Barcode: json["r2_barcode"],
    r3: json["r3"],
    r3Verified: json["r3_verified"],
    r3VerifiedImage: json["r3_verified_image"],
    r3Qr: json["r3_qr"],
    r3Barcode: json["r3_barcode"],
    r4: json["r4"],
    r4Verified: json["r4_verified"],
    r4VerifiedImage: json["r4_verified_image"],
    r4Qr: json["r4_qr"],
    r4Barcode: json["r4_barcode"],
    r5: json["r5"],
    r5Verified: json["r5_verified"],
    r5VerifiedImage: json["r5_verified_image"],
    r5Qr: json["r5_qr"],
    r5Barcode: json["r5_barcode"],
    f1: json["f1"],
    f1Verified: json["f1_verified"],
    f1VerifiedImage: json["f1_verified_image"],
    f1Qr: json["f1_qr"],
    f1Barcode: json["f1_barcode"],
    f2: json["f2"],
    f2Verified: json["f2_verified"],
    f2VerifiedImage: json["f2_verified_image"],
    f2Qr: json["f2_qr"],
    f2Barcode: json["f2_barcode"],
    b1: json["b1"],
    b1Verified: json["b1_verified"],
    b1VerifiedImage: json["b1_verified_image"],
    b1Qr: json["b1_qr"],
    b1Barcode: json["b1_barcode"],
    b2: json["b2"],
    b2Verified: json["b2_verified"],
    b2VerifiedImage: json["b2_verified_image"],
    b2Qr: json["b2_qr"],
    b2Barcode: json["b2_barcode"],
    dp1: json["dp1"],
    dp1Verified: json["dp1_verified"],
    dp1VerifiedImage: json["dp1_verified_image"],
    dp1Qr: json["dp1_qr"],
    dp1Barcode: json["dp1_barcode"],
    dp2: json["dp2"],
    dp2Verified: json["dp2_verified"],
    dp2VerifiedImage: json["dp2_verified_image"],
    dp2Qr: json["dp2_qr"],
    dp2Barcode: json["dp2_barcode"],
    mp1: json["mp1"],
    mp1Verified: json["mp1_verified"],
    mp1VerifiedImage: json["mp1_verified_image"],
    mp1Qr: json["mp1_qr"],
    mp1Barcode: json["mp1_barcode"],
    mp2: json["mp2"],
    mp2Verified: json["mp2_verified"],
    mp2VerifiedImage: json["mp2_verified_image"],
    mp2Qr: json["mp2_qr"],
    mp2Barcode: json["mp2_barcode"],
    mp3: json["mp3"],
    mp3Verified: json["mp3_verified"],
    mp3VerifiedImage: json["mp3_verified_image"],
    mp3Qr: json["mp3_qr"],
    mp3Barcode: json["mp3_barcode"],
    mp4: json["mp4"],
    mp4Verified: json["mp4_verified"],
    mp4VerifiedImage: json["mp4_verified_image"],
    mp4Qr: json["mp4_qr"],
    mp4Barcode: json["mp4_barcode"],
    mp5: json["mp5"],
    mp5Verified: json["mp5_verified"],
    mp5VerifiedImage: json["mp5_verified_image"],
    mp5Qr: json["mp5_qr"],
    mp5Barcode: json["mp5_barcode"],
    mp6: json["mp6"],
    mp6Verified: json["mp6_verified"],
    mp6VerifiedImage: json["mp6_verified_image"],
    mp6Qr: json["mp6_qr"],
    mp6Barcode: json["mp6_barcode"],
    mp7: json["mp7"],
    mp7Verified: json["mp7_verified"],
    mp7VerifiedImage: json["mp7_verified_image"],
    mp7Qr: json["mp7_qr"],
    mp7Barcode: json["mp7_barcode"],
    mp8: json["mp8"],
    mp8Verified: json["mp8_verified"],
    mp8VerifiedImage: json["mp8_verified_image"],
    mp8Qr: json["mp8_qr"],
    mp8Barcode: json["mp8_barcode"],
    vehicleInwardComplete: json["vehicle_inward_complete"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    organisation: json["organisation"],
    vehicle: json["vehicle"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle_details": vehicleDetails?.toJson(),
    "l1": l1,
    "l1_verified": l1Verified,
    "l1_verified_image": l1VerifiedImage,
    "l1_qr": l1Qr,
    "l1_barcode": l1Barcode,
    "l2": l2,
    "l2_verified": l2Verified,
    "l2_verified_image": l2VerifiedImage,
    "l2_qr": l2Qr,
    "l2_barcode": l2Barcode,
    "l3": l3,
    "l3_verified": l3Verified,
    "l3_verified_image": l3VerifiedImage,
    "l3_qr": l3Qr,
    "l3_barcode": l3Barcode,
    "l4": l4,
    "l4_verified": l4Verified,
    "l4_verified_image": l4VerifiedImage,
    "l4_qr": l4Qr,
    "l4_barcode": l4Barcode,
    "l5": l5,
    "l5_verified": l5Verified,
    "l5_verified_image": l5VerifiedImage,
    "l5_qr": l5Qr,
    "l5_barcode": l5Barcode,
    "r1": r1,
    "r1_verified": r1Verified,
    "r1_verified_image": r1VerifiedImage,
    "r1_qr": r1Qr,
    "r1_barcode": r1Barcode,
    "r2": r2,
    "r2_verified": r2Verified,
    "r2_verified_image": r2VerifiedImage,
    "r2_qr": r2Qr,
    "r2_barcode": r2Barcode,
    "r3": r3,
    "r3_verified": r3Verified,
    "r3_verified_image": r3VerifiedImage,
    "r3_qr": r3Qr,
    "r3_barcode": r3Barcode,
    "r4": r4,
    "r4_verified": r4Verified,
    "r4_verified_image": r4VerifiedImage,
    "r4_qr": r4Qr,
    "r4_barcode": r4Barcode,
    "r5": r5,
    "r5_verified": r5Verified,
    "r5_verified_image": r5VerifiedImage,
    "r5_qr": r5Qr,
    "r5_barcode": r5Barcode,
    "f1": f1,
    "f1_verified": f1Verified,
    "f1_verified_image": f1VerifiedImage,
    "f1_qr": f1Qr,
    "f1_barcode": f1Barcode,
    "f2": f2,
    "f2_verified": f2Verified,
    "f2_verified_image": f2VerifiedImage,
    "f2_qr": f2Qr,
    "f2_barcode": f2Barcode,
    "b1": b1,
    "b1_verified": b1Verified,
    "b1_verified_image": b1VerifiedImage,
    "b1_qr": b1Qr,
    "b1_barcode": b1Barcode,
    "b2": b2,
    "b2_verified": b2Verified,
    "b2_verified_image": b2VerifiedImage,
    "b2_qr": b2Qr,
    "b2_barcode": b2Barcode,
    "dp1": dp1,
    "dp1_verified": dp1Verified,
    "dp1_verified_image": dp1VerifiedImage,
    "dp1_qr": dp1Qr,
    "dp1_barcode": dp1Barcode,
    "dp2": dp2,
    "dp2_verified": dp2Verified,
    "dp2_verified_image": dp2VerifiedImage,
    "dp2_qr": dp2Qr,
    "dp2_barcode": dp2Barcode,
    "mp1": mp1,
    "mp1_verified": mp1Verified,
    "mp1_verified_image": mp1VerifiedImage,
    "mp1_qr": mp1Qr,
    "mp1_barcode": mp1Barcode,
    "mp2": mp2,
    "mp2_verified": mp2Verified,
    "mp2_verified_image": mp2VerifiedImage,
    "mp2_qr": mp2Qr,
    "mp2_barcode": mp2Barcode,
    "mp3": mp3,
    "mp3_verified": mp3Verified,
    "mp3_verified_image": mp3VerifiedImage,
    "mp3_qr": mp3Qr,
    "mp3_barcode": mp3Barcode,
    "mp4": mp4,
    "mp4_verified": mp4Verified,
    "mp4_verified_image": mp4VerifiedImage,
    "mp4_qr": mp4Qr,
    "mp4_barcode": mp4Barcode,
    "mp5": mp5,
    "mp5_verified": mp5Verified,
    "mp5_verified_image": mp5VerifiedImage,
    "mp5_qr": mp5Qr,
    "mp5_barcode": mp5Barcode,
    "mp6": mp6,
    "mp6_verified": mp6Verified,
    "mp6_verified_image": mp6VerifiedImage,
    "mp6_qr": mp6Qr,
    "mp6_barcode": mp6Barcode,
    "mp7": mp7,
    "mp7_verified": mp7Verified,
    "mp7_verified_image": mp7VerifiedImage,
    "mp7_qr": mp7Qr,
    "mp7_barcode": mp7Barcode,
    "mp8": mp8,
    "mp8_verified": mp8Verified,
    "mp8_verified_image": mp8VerifiedImage,
    "mp8_qr": mp8Qr,
    "mp8_barcode": mp8Barcode,
    "vehicle_inward_complete": vehicleInwardComplete,
    "created_on": createdOn?.toIso8601String(),
    "organisation": organisation,
    "vehicle": vehicle,
    "created_by": createdBy,
  };
}

class VehicleDetails {
  int? pk;
  String? vehicleNo;

  VehicleDetails({
    this.pk,
    this.vehicleNo,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
    pk: json["pk"],
    vehicleNo: json["vehicle_no"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "vehicle_no": vehicleNo,
  };
}
