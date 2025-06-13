import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studybuddy/routes/app_router.dart';
import 'package:studybuddy/utils/api.dart';

@RoutePage()
class ViewNotesScreen extends StatefulWidget {
  final int id;

  const ViewNotesScreen({super.key, required this.id});

  @override
  State<ViewNotesScreen> createState() => _ViewNotesScreenState();
}

class _ViewNotesScreenState extends State<ViewNotesScreen> {
  List<dynamic> _notes = [];
  bool _isLoading = false;
  bool _quiz_exist = false;
  Map<int, bool> showFullText = {};
  @override
  void initState() {
    getNotes();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.chevronLeft),
          color: Colors.white,
          onPressed: () {
            context.router.pop();
          },
        ),
        title: const Text("Study Notes", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF6D3EDD),
      ),

      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(24.0),
                children: [
                  if (_notes.isEmpty)
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "No Data Found",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._notes.asMap().entries.map((entry) {
                      int i = entry.key;
                      var note = entry.value;
                      bool isExpanded = showFullText[i] ?? false;

                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note['topic'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 8),

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFullText[i] = !isExpanded;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note['note'],
                                      overflow:
                                          isExpanded
                                              ? TextOverflow.visible
                                              : TextOverflow.ellipsis,
                                      maxLines: isExpanded ? null : 2,
                                      style: TextStyle(fontSize: 16),
                                    ),

                                    SizedBox(height: 8),
                                    if (isExpanded) ...[
                                      SizedBox(height: 16),
                                      Text(
                                        "Examples",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Divider(),
                                      ...(note['examples'] as List<dynamic>)
                                          .map<Widget>(
                                            (example) => Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                              ),
                                              child: Text(
                                                example.toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                
                  if (!_quiz_exist)
                  ElevatedButton(
                    onPressed: (){
                      generateQuiz();
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D3EDD),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 1
                    ),
                    child:Text("Generate Quiz",style: TextStyle(color: Colors.white),)
                  ),
                ],
              ),
    );
  }

  void getNotes() async {
    setState(() => _isLoading = true);

    try {
      final res = await ApiService.instance.get(
        '/studyplan/get_simplified_notes/${widget.id}',
      );
      final body = res.data;
      // print('Res data: ${body}');
      setState(() {
        _notes = body['data']['study_notes'] ?? [];
        _quiz_exist = body['data']['quiz_exists'] ?? false;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void generateQuiz() async {
    setState(() => _isLoading = true);

    try {
      final res = await ApiService.instance.post(
        '/studyplan/generate_quiz/${widget.id}',
      );
      final body = res.data;
      print('Res data: ${body}');
      if (body['success']) {
        Fluttertoast.showToast(
            msg: 'Quiz generated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          context.router.replace(TakeQuizRoute(quizid: int.parse(body['data']['quiz_id'].toString())));
        getNotes();
      } else {
        print('Error generating quiz: ${body['message']}');
      }
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
}
