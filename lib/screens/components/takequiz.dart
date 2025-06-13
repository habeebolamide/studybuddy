import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studybuddy/utils/api.dart';

@RoutePage()
class TakeQuizPage extends StatefulWidget {
  const TakeQuizPage({super.key, required this.quizid});

  final int quizid;

  @override
  State<TakeQuizPage> createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  List<dynamic> _quizzes = [];
  int? selected_quiz_id ;
  Map<int, String?> _selectedAnswers = {};

  @override
  void initState() {
    getQuiz();
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
        title: const Text("Take Quiz", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF6D3EDD),
      ),

      body:
          _quizzes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ..._quizzes.asMap().entries.map((entry) {
                    int i = entry.key;
                    var quiz = entry.value;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${i + 1}.) ${quiz['question']}' ?? 'No question',
                            ),
                            SizedBox(height: 16),

                            Column(
                              children:
                                  (quiz['options'] as List<dynamic>).map<
                                    Widget
                                  >((option) {
                                    return RadioListTile<dynamic>(
                                      title: Text(option.toString()),
                                      value: option,
                                      groupValue: _selectedAnswers[quiz['id']],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedAnswers[quiz['id']] = value;
                                        });
                                      },
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        submitQuiz();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6D3EDD),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
    );
  }

  void getQuiz() async {
    try {
      final res = await ApiService.instance.get(
        '/studyplan/get_quiz/${widget.quizid}',
      );
      final body = res.data;

      Map <Object,dynamic> quizzes = body['data'] ?? [];
      // print('questions : ${quizzes['id']}');
      
      setState(() {
        selected_quiz_id = quizzes['id'];
        _quizzes = quizzes['questions'] ;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void submitQuiz () async {
    if (_selectedAnswers.length != _quizzes.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please answer all questions before submitting.')),
      );
      return;
    }
    List<Map<String, dynamic>> formattedAnswers = _selectedAnswers.entries.map((entry) => {
      'question_id': entry.key,
      'selected_answer': entry.value,
    }).toList();

    var data = {
      'quiz_id' : selected_quiz_id,
      'selected_answers' :formattedAnswers
    };

    try {
      final res = await ApiService.instance.post(
        '/studyplan/submit_quiz',
        data: data 
      );
      final body = res.data;

      print('body : ${body}');
      
    } catch (e) {
      print('Error: $e');
    }
  }
}
