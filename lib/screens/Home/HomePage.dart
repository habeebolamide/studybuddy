import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text('Awesome Quotes'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
        
        ),

        body: ElevatedButton(onPressed: (){
          Navigator.pushReplacementNamed(context, '/login');

        }, 
        child:Text("yooo") ),
    );
  }
}