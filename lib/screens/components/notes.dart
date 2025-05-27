import 'package:flutter/material.dart';
import 'package:studybuddy/routes/app_router.dart';
import 'package:studybuddy/utils/api.dart';
import 'package:auto_route/auto_route.dart';

class StudyNotes extends StatefulWidget {
  const StudyNotes({super.key});

  @override
  State<StudyNotes> createState() => _StudyNotesState();
}

class _StudyNotesState extends State<StudyNotes> {
  List<dynamic> _notes = [];
  bool _isLoading = false;

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Notes", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF6D3EDD),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_notes.isEmpty)
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
                  ..._notes.map((note) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: const Color(0xFF6D3EDD),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note['course_title'] ?? 'Untitled Note',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              note['course_code'] ?? 'Untitled Note',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              note['course_description'] ?? 'Untitled Note',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.router.push(
                                        ViewNotesRoute(id: note['id']),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Color(0xFF6D3EDD),
                                    ),
                                    child: const Text("View Note"),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.router.push(
                                        QuizRoute(note: note),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Color(0xFF6D3EDD),
                                    ),
                                    child: const Text("Take Quiz"),
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
        '/studyplan/get_all_study_notes',
      );
      final body = res.data;

      setState(() {
        _notes = body['data'] ?? [];
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
