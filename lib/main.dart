import 'package:flutter/material.dart';
import 'package:weatherapp/Screen/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      home: HomeScreen(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white)
    );
  }
}