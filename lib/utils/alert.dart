import 'package:flutter/material.dart';

class AlertUtil {
  static void showAlert(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Alert'),
            content: const Text("This is an alert dialog."),
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
