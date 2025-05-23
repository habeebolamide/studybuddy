import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class UploadDocsScreen extends StatefulWidget {
  const UploadDocsScreen({super.key});

  @override
  State<UploadDocsScreen> createState() => _UploadDocsScreenState();
}

class _UploadDocsScreenState extends State<UploadDocsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controller = {
    'course_name': TextEditingController(),
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
        title: Text("Create Study Plan", style: TextStyle(color: Colors.white)),
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

                      return null;
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
                      // pickFile();
                    },
                    child: Text("Upload"),
                  ),

                  SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {},
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
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),

                  SizedBox(height: 16),
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

      print('File Name: ${file.name}');
      print('File Size: ${file.size}');
      print('File Path: ${file.path}');
    } else {
      // User canceled the picker
      print("No file selected");
    }
  }
}
