// To parse this JSON data, do
//
//     final getIncomingModel = getIncomingModelFromJson(jsonString);

import 'dart:convert';

List<GetIncomingModel> getIncomingModelFromJson(String str) =>
    List<GetIncomingModel>.from(
        json.decode(str).map((x) => GetIncomingModel.fromJson(x)));

String getIncomingModelToJson(List<GetIncomingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetIncomingModel {
  int? pk;
  String? vehicleVehicleNo;
  DateTime? createdOn;

  GetIncomingModel({
    this.pk,
    this.vehicleVehicleNo,
    this.createdOn,
  });

  factory GetIncomingModel.fromJson(Map<String, dynamic> json) =>
      GetIncomingModel(
        pk: json["pk"],
        vehicleVehicleNo: json["vehicle__vehicle_no"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "vehicle__vehicle_no": vehicleVehicleNo,
        "created_on": createdOn?.toIso8601String(),
      };
}
