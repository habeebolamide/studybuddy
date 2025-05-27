import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studybuddy/utils/api.dart';

@RoutePage()
class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.note});

  final Map<Object, dynamic> note;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> _quizzes = [];
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

                  Expanded(
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
        '/studyplan/get_quiz/${widget.note['id']}',
      );
      final body = res.data;

      Map <Object,dynamic> quizzes = body['data'] ?? [];
      // print('questions : ${quizzes['questions']}');
      
      setState(() {
        _quizzes = quizzes['questions'] ;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void submitQuiz (){
    print('answer: ${_selectedAnswers}');
  }
}
