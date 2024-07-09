import 'package:flutter/material.dart';
import 'package:weather_app/pages/splash.dart';
import 'package:weather_app/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/nextPage': (context) => HomePage(),
      },
    );
  }
}
