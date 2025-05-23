import 'package:flutter/material.dart';
import 'package:studybuddy/utils/api.dart';

class StudyNotes extends StatefulWidget {
  const StudyNotes({super.key});

  @override
  State<StudyNotes> createState() => _StudyNotesState();
}

class _StudyNotesState extends State<StudyNotes> {
  List<dynamic> _notes = [];

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
          _notes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children:
                    _notes.map((note) {
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
                              SizedBox(height: 10),
                              Text(
                                note['course_code'] ?? 'Untitled Note',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                note['course_description'] ?? 'Untitled Note',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // View note action
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Color(0xFF6D3EDD),
                                      ),
                                      child: const Text("View Note"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ), // Space between buttons
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Delete action
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
              ),
    );
  }

  void getNotes() async {
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
    }
  }
}
