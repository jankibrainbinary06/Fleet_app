// To parse this JSON data, do
//
//     final saveVehicalModel = saveVehicalModelFromJson(jsonString);

import 'dart:convert';

SaveVehicalModel saveVehicalModelFromJson(String str) => SaveVehicalModel.fromJson(json.decode(str));

String saveVehicalModelToJson(SaveVehicalModel data) => json.encode(data.toJson());

class SaveVehicalModel {
  VehicleData? vehicleData;
  String? message;

  SaveVehicalModel({
    this.vehicleData,
    this.message,
  });

  factory SaveVehicalModel.fromJson(Map<String, dynamic> json) => SaveVehicalModel(
    vehicleData: json["vehicle_data"] == null ? null : VehicleData.fromJson(json["vehicle_data"]),
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_data": vehicleData?.toJson(),
    "Message": message,
  };
}

class VehicleData {
  int? pk;
  String? vehicleNo;

  VehicleData({
    this.pk,
    this.vehicleNo,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
    pk: json["pk"],
    vehicleNo: json["vehicle_no"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "vehicle_no": vehicleNo,
  };
}
