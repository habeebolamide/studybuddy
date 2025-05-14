import 'package:flutter/material.dart';
import 'package:studybuddy/layout.dart';
import 'package:studybuddy/screens/auth/login.dart';
import 'package:studybuddy/screens/auth/register.dart';
import 'package:studybuddy/screens/components/upload.dart';
import './screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        // '/': (context) => OnboardingScreen(),
        '/': (context) => CheckAuth(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/create': (context) => UploadDocs(),
      },
    );
  }
}


class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = Layout();
    } else {
      child = LoginPage();
    }
    return Scaffold(
      body: child,
    );
  }
}