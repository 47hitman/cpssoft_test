import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'splashScreen.dart';

void main() {
  runApp(const Cuaca());
}

class Cuaca extends StatelessWidget {
  const Cuaca({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "cppsoft_test",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Set the SplashScreen as the initial route
      routes: {
        '/home': (context) => HomeScreen(), // Add the HomeScreen route
      },
    );
  }
}
