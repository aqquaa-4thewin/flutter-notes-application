import 'package:flutter/material.dart';
import 'package:flutter_application_2/shared/shared.dart';

Widget customDialog(task, Function onAction) {
  return AlertDialog(
      content: const Text("Are you sure you want to continue?"),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        MaterialButton(
            onPressed: () {
              Navigator.of(navigatorKey.currentState!.context).pop();
            },
            color: const Color(0xFF6898EE),
            child: const Text(
              "no",
            )),
        MaterialButton(
            onPressed: () {
              onAction(task); // Execute the passed onAction function
              Navigator.of(navigatorKey.currentState!.context).pop();
            },
            color: const Color(0xFF6898EE),
            child: const Text(
              "yes",
            ))
      ]);
}
