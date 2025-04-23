import 'package:flutter/material.dart';

class AlertUtil {
  static void showAlert(BuildContext context, String title, String message){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ]

        );
      },
    );
  }
}
