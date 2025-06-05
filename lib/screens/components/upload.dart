import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:auto_route/auto_route.dart';
import 'package:studybuddy/routes/app_router.dart';
import 'package:studybuddy/utils/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class UploadDocsScreen extends StatefulWidget {
  const UploadDocsScreen({super.key});

  @override
  State<UploadDocsScreen> createState() => _UploadDocsScreenState();
}

class _UploadDocsScreenState extends State<UploadDocsScreen> {
  String? filename;
  File? uploaded_file;
  bool showBtn = false;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controller = {
    'course_name': TextEditingController(),
    'course_code': TextEditingController(),
    'course_title': TextEditingController(),
    'course_description': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.chevronLeft),
          color: Colors.white,
          onPressed: () {
            context.router.pop();
          },
        ),
        title: Text(
          "Create Study Notes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF6D3EDD),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _controller['course_code'],
                    decoration: InputDecoration(
                      labelText: 'Course Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter course code';
                    },
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _controller['course_title'],
                    decoration: InputDecoration(
                      labelText: 'Course Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter the course title';

                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _controller['course_description'],
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter description';

                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      pickFile();
                    },
                    child: Text("Upload"),
                  ),

                  SizedBox(height: 16),
                  if (filename != null)
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),

                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.filePdf, color: Colors.red),
                            SizedBox(width: 10),
                            Expanded(child: Text('${filename}')),
                            IconButton(
                              onPressed: () {
                                unPickfile();
                              },
                              icon: Icon(
                                FontAwesomeIcons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // _isLoading
                  //     ? Center(child: CircularProgressIndicator())
                  //     :
                  ElevatedButton(
                    onPressed: _isLoading ? null : createStudyNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D3EDD),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _isLoading ? "Creating......" : "Create",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),

                  SizedBox(height: 16),

                  if (showBtn)
                    Row(
                      children: [
                        TextButton(onPressed: () {}, child: Text("View Notes")),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        uploaded_file = File(file.path!);
        filename = file.name;
      });
    } else {
      // User canceled the picker
      print("No file selected");
    }
  }

  void createStudyNote() async {
    if (uploaded_file == null) {
      _showError("Please select a file before submitting.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      FormData formData = FormData.fromMap({
        'course_title': _controller['course_title']!.text.trim(),
        'course_code': _controller['course_code']!.text.trim(),
        'course_description': _controller['course_description']!.text.trim(),
        'uploaded_file': await MultipartFile.fromFile(
          uploaded_file!.path,
          filename: filename,
        ),
      });
      
      await ApiService.instance.post(
        '/studyplan/uploadfile',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      setState(() => showBtn = true);

      Fluttertoast.showToast(
        msg: 'You will be notified when yr notes are ready',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      context.router.replace(DashboardRoute());

      // print("Response: ${res.data}");
      // Optionally show a success message or redirect user
    } on DioException catch (e) {
      print('Error: ${e.response}');
      if (e.response?.data != null ) {
        Fluttertoast.showToast(
          msg: '${e.response?.data['error']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void unPickfile() {
    setState(() {
      filename = null;
    });
    print("File selection cleared");
  }
}
