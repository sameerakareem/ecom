

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppController {
  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            MaterialButton(
                elevation: 5,
                color: Colors.blueGrey,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: const Text("Ok",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        );
      },
    );
  }
  /// saveIsLogged
  static Future<void> saveIsLogged(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', value);
  }

  /// getisLogged
  static Future<bool> getisLogged() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLogged = prefs.getBool('isLogged') ?? false;
    return isLogged;
  }
}

