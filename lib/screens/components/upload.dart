import 'package:flutter/material.dart';

class UploadDocs extends StatefulWidget {
  const UploadDocs({super.key});

  @override
  State<UploadDocs> createState() => _UploadDocsState();
}

class _UploadDocsState extends State<UploadDocs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Study Plan"),
        centerTitle: true,
        backgroundColor: Color(0xFF6D3EDD),
        elevation: 0,
      ),
    );
  }
}