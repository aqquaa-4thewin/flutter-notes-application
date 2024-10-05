import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/splash.dart';
import 'package:flutter_application_2/shared/shared.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'website',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade700),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
