import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

      body: _isLoading ? 
              const Center(child: CircularProgressIndicator())
              : ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(24.0),
                children: [
                  if(_notes.isEmpty)
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
                            )
                          ],
                        ),
                      ),
                    )
                    else
                     ..._notes.asMap().entries.map((entry) {
                        int i = entry.key;
                        var note = entry.value;
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
                                      fontSize: 18
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    note['note'],
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        );
                     })
                ],
              )
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
        _notes = body['data'] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}