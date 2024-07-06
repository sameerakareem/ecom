import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/registration_model.dart';
import '../utils/utls.dart';
import 'api_service.dart';
import 'network_response.dart';
import 'package:http/http.dart' as http;

class SyncManager {

  static Future<NetworkResponse<RegistrationModel>> register(
      RegistrationModel model,
      ) async {
    String endPoint = "${Urls.register}";
    try {
      final response = await ApiRequestManager.post(endPoint, model.toJson());
      print(response.body);
      if (response.statusCode == 201) {
        ApiResponse apiResponse =
        ApiResponse.fromJson(json.decode(response.body));

        String modelJson = json.encode(model.toResponseJson());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('registration_model', modelJson);

        return NetworkResponse.success(model);
      } else {
        return NetworkResponse.error(response.body, response: model);
      }
    } catch (error) {
      return NetworkResponse.error("Registration Failed", response: model);
    }
  }
}