// To parse this JSON data, do
//
//     final getTransporterModel = getTransporterModelFromJson(jsonString);

import 'dart:convert';

List<String> getTransporterModelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String getTransporterModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
