import 'package:flutter/material.dart';
import 'package:studybuddy/screens/auth/login.dart';
import 'package:studybuddy/screens/auth/register.dart';
import './screens/onboarding.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
