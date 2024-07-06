import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/registration_model.dart';

class AuthRepository {
  Future<RegistrationModel?> getSavedRegistrationModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? modelJson = prefs.getString('registration_model');
    if (modelJson != null) {
      Map<String, dynamic> jsonMap = json.decode(modelJson);
      return RegistrationModel.fromJson(jsonMap);
    }
    return null;
  }
}
