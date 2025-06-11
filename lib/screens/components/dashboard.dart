import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:studybuddy/helpers/notification_helper.dart';
import 'package:studybuddy/routes/app_router.dart';

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

  @override
  void initState() {
    loadData();
    super.initState();

    FirebaseMessaging.onMessage.listen((message) {
      showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final id = message.data['study_plan_id'];
      if (id != null) {
        context.router.replace(
          ViewNotesRoute(id: id),
        ); // Or pass args if needed
      }
    });
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
                SizedBox(height: _deviceHeight * 0.015),
                _dashboardActions(),
                SizedBox(height: _deviceHeight * 0.015),
                _recentUploads(),
                SizedBox(height: _deviceHeight * 0.015),
                Analytics(),
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
        vertical: _deviceHeight * 0.015,
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.file_present, color: Colors.red),
                    title: Text("Document ${index + 1}"),
                    subtitle: Text("Uploaded on ${DateTime.now().toString()}"),
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
      height: _deviceHeight * 0.20,
      width: _deviceWidth,

      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D3EDD), Color(0xFFF052C6)],
          ),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(45.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Welcome\n${_user?['uname']}!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),

              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF6D3EDD)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardActions() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.02,
        vertical: _deviceHeight * 0.015,
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
                UploadDocsRoute(),
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

  Widget Analytics() {
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
                  const Text(
                    'You\'ve completed 3/5 quizzes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  LinearProgressBar(
                    maxSteps: 5,
                    progressType:
                        LinearProgressBar
                            .progressTypeLinear, // Use Linear progress
                    currentStep: 3,
                    progressColor: Color(0xFFF052C6),
                    backgroundColor: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
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
        _user = jsonDecode(userData); // decode string to map
      }); // decode string to map
    } else {
      print('No user data found');
    }
  }
}
