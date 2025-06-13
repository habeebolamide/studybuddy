import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studybuddy/routes/app_router.dart';
import 'package:studybuddy/utils/api.dart';
import 'package:auto_route/auto_route.dart';


@RoutePage()
class QuizListPage extends StatefulWidget {
  const QuizListPage({super.key});

  @override
  State<QuizListPage> createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  List<dynamic> _quizzes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
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
        title: const Text("Quizzes", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF6D3EDD),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_quizzes.isEmpty)
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      color: Colors.red,
                      child: const Padding(
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
                    ),
                  ..._quizzes.map((quiz) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: const Color(0xFF6D3EDD),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quiz['title'] ?? 'Untitled Note',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                           
                            const SizedBox(height: 10),
                            if(quiz['status'] == 'uncompleted')
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.router.push(
                                        TakeQuizRoute(quizid: quiz['id']),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Color(0xFF6D3EDD),
                                    ),
                                    child: const Text("Take Quiz",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ) 
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
    );
  }

  void getNotes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final res = await ApiService.instance.get(
        '/studyplan/get_allquiz',
      );
      final body = res.data;

      setState(() {
        _quizzes = body['data'] ?? [];
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
