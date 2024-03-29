import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HttpService {
  static Future<http.Response?> getApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
      }
      return http.get(
        Uri.parse(url),
        headers: header,
      );
    } catch (e) {
      // showToast(e.toString());
      return null;
    }
  }

  static Future<http.Response?> postApi({
    required String url,
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
      //  print("Body => $body");
      }
      return http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
    } catch (e) {
      // showToast(e.toString());
      print("=============>>>>>> ${e.toString()} <<<<<<<<=======");
      return null;
    }
  }

  static Future<http.Response?> patchApi({
    required String url,
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      if (header == null) {}
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
        print("Body => $body");
      }
      return http.patch(
        Uri.parse(url),
        headers: header,
        body: body,
      );
    } catch (e) {
      // showToast(e.toString());
      print("=============>>>>>> ${e.toString()} <<<<<<<<=======");
      return null;
    }
  }





  static Future<http.Response?> postMultipart({
    required String url,
    Map<String, String>? headers,
    required Map<String, String> fields,
    required List<String> imagesBase64,
    required List<String> extensionType,
  }) async {
    try {
      if (kDebugMode) {
        print("POST Multipart Request - URL: $url, Headers: $headers");
        print("Fields: $fields");
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));

      if (headers != null) {
        request.headers.addAll(headers);
      }

      // fields.forEach((key, value) {
      //   request.fields[key] = value;
      // });
request.fields.addAll(fields);
      // for (int i = 0; i < imagesBase64.length; i++) {
      //   String imageBase64 = imagesBase64[i];
      //   Uint8List bytes = base64.decode(imageBase64);
      //
      //   request.files.add(http.MultipartFile.fromBytes(
      //     'image$i',
      //     bytes,
      //     filename: 'image_$i.jpg',
      //     contentType: MediaType('image', extensionType[i]),
      //   ));
      // }

      var response = await request.send();
      var streamedResponse = await http.Response.fromStream(response);

      return streamedResponse;
    } catch (e) {
      print("Error in Multipart POST request: $e");
      return null;
    }
  }

}
