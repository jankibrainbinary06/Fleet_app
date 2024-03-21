import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  int? pk;
  String? vehicleNo;

  SearchModel({
    this.pk,
    this.vehicleNo,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        pk: json["pk"],
        vehicleNo: json["vehicle_no"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "vehicle_no": vehicleNo,
      };
}
