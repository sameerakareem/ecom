import 'dart:io';
import 'package:http/http.dart' as http;

import 'network_response.dart';

class ApiRequestManager {
  static Future<http.Response> get(String endPoint,
      [bool isJson = true]) async {
    try {

      print(endPoint);

      final response = await http.get(
        Uri.parse(endPoint),
        headers: {},
      );

      return response;
    } catch (error) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  static Future<http.Response> post(String endPoint, var body,
      [bool isJson = true]) async {
    try {

      print(endPoint);
      print(body);

      final Map<String, String> headers = {};

       // headers['Content-Type'] = 'application/json';
        final http.Response response = await http.post(
          Uri.parse(endPoint),
          headers: headers,
          body: body,
        );


      return response;
    } catch (error) {
      // Handle errors or exceptions
      rethrow;
    }
  }

}
