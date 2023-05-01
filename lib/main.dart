import 'package:flutter/material.dart';
import 'package:house_rules/pages/loginPage.dart';
import 'package:house_rules/pages/mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const MyLoginPage());
  }
}
