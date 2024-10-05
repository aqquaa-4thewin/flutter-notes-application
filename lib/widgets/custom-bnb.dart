import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/categories.dart';
import 'package:flutter_application_2/pages/completed-tasks.dart';
import 'package:flutter_application_2/pages/home.dart';
import 'package:flutter_application_2/shared/shared.dart';

Widget customBNB() {
  return Container(
    height: 60,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              navigatorKey.currentState!.context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(
            Icons.home,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushReplacement<void, void>(
                navigatorKey.currentState!.context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CategoriesPage(),
                ));
          },
          icon: const Icon(
            Icons.list,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushReplacement<void, void>(
                navigatorKey.currentState!.context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CompletedTasksPage(),
                ));
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
          ),
        ),
      ],
    ),
  );
}
