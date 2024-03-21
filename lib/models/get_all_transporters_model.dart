// To parse this JSON data, do
//
//     final getalltransporters = getalltransportersFromJson(jsonString);

import 'dart:convert';

List<dynamic> getalltransportersFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String getalltransportersToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

