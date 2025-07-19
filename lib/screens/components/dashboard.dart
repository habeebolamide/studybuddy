import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_route/auto_route.dart';

import 'package:studybuddy/routes/app_router.dart';
import 'package:studybuddy/utils/api.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  Map<String, dynamic>? _user;
  Map<String, dynamic>? _analytics ;
  bool _isLoading = false;

  @override
  void initState() {
    loadData();
    analytics();
    super.initState();
  }

  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topLayerWidget(),
                SizedBox(height: _deviceHeight * 0.01),
                _dashboardActions(),
                SizedBox(height: _deviceHeight * 0.01),
                _recentUploads(),
                SizedBox(height: _deviceHeight * 0.01),
                quizAnalytics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentUploads() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.02,
        // vertical: _deviceHeight * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          

          Text(
            "Recent Uploads",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _analytics?['recent_uploads']?.length ?? 0,
              itemBuilder: (context, index) {
                  final recentUploads = _analytics?['recent_uploads'] ?? {};
                  final item = recentUploads[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.file_present, color: Colors.red),
                    title: Text(item['course_title'] ?? 'Untitled Document'),
                    subtitle: Text('Uploaded on ${DateFormat.yMMMd().format(DateTime.parse(item['created_at']))}'),
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }

  Widget _topLayerWidget() {
  return SizedBox(
    height: _deviceHeight * 0.25,
    width: _deviceWidth,
    child: ClipPath(
      clipper: WavyHeaderClipper(),
      child: Container(
        padding: EdgeInsets.only(
          top: _deviceHeight * 0.02,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D3EDD), Color(0xFFF052C6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Welcome,\n${_user?['uname']}!",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF6D3EDD)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  Widget _dashboardActions() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          Text(
            'Dashboard Actions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20), // Spacing between text and cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _dashboardCard(
                FontAwesomeIcons.upload,
                "Upload",
                [Color(0xFF6D3EDD), Color(0xFFF052C6)],
                _deviceHeight,
                UploadDocsRoute(),
              ),
              _dashboardCard(
                FontAwesomeIcons.book,
                "Create",
                [Colors.blue, Colors.blue],
                _deviceHeight,
                UploadDocsRoute(),
              ),
              _dashboardCard(
                FontAwesomeIcons.brain,
                "Quiz",
                [Colors.deepPurple, Colors.deepPurple],
                _deviceHeight,
                QuizListRoute(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dashboardCard(
    IconData icon,
    String label,
    List<Color> gradientColors,
    double _deviceHeight,
    Url,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            context.router.push(Url);
            // Navigator.pushReplacementNamed(context, Url);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: _deviceHeight * 0.025,
              horizontal: _deviceWidth * 0.08,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 30, color: Colors.white),
                SizedBox(height: _deviceHeight * 0.01),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget quizAnalytics() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.02,
          vertical: _deviceHeight * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quiz Analytics",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(100),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'You\'ve completed ${_analytics?['completed_quizzes_count'] ?? 0 } / ${_analytics?['total_quizzes_count'] ?? 0 } quizzes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  LinearProgressBar(
                    maxSteps: (_analytics?['total_quizzes_count'] ?? 0) > 0
                        ? _analytics!['total_quizzes_count']
                        : 1,
                    currentStep: _analytics?['completed_quizzes_count'] ?? 0,
                    minHeight: 15,
                    progressColor: Color(0xFFF052C6),
                    backgroundColor: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    progressType: LinearProgressBar.progressTypeLinear,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');

    if (userData != null) {
      setState(() {
        _user = jsonDecode(userData); 
      }); 
    } else {
      print('No user data found');
    }
  }

  void analytics() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final res = await ApiService.instance.get(
        '/dashboard/analytics',
      );
      final body = res.data;

      setState(() {
        _analytics = body['data'] ?? [];
      });
      // print('Analytics data: $_analytics');
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class WavyHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Start at top left
    path.lineTo(0, size.height - 40);

    // Create wave using cubic bezier curve
    path.quadraticBezierTo(
      size.width / 4, size.height,
      size.width / 2, size.height - 30,
    );
    path.quadraticBezierTo(
      3 * size.width / 4, size.height - 60,
      size.width, size.height - 30,
    );

    // Finish at top right
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
