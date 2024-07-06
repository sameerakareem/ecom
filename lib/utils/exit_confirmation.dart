import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_controller.dart';

class ExitConfirmationDialog {
  static Future<void> show(BuildContext context, Function() onLogout) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                _handleExit(context, onLogout);
              },
            ),
          ],
        );
      },
    );
  }

  static void _handleExit(BuildContext context, Function() onLogout) {
    setLoginStatus(onLogout);
    SystemNavigator.pop();
  }

  static void setLoginStatus(Function() onLogout) {
    AppController.saveIsLogged(false).then((_) {
      onLogout(); // Call the callback function after updating the login status
    });
  }
}
