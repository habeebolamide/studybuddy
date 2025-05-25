import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_route/auto_route.dart';
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
  }

  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _topLayerWidget(),
            _dashboardActions(),
            // Expanded(child: SingleChildScrollView(child:)),
          ],
        ),
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
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.02,
          vertical: _deviceHeight * 0.06,
        ),

        child: Row(
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
              UploadDocsRoute()
            ),
            _dashboardCard(
              FontAwesomeIcons.brain,
              "Quiz",
              [Colors.deepPurple, Colors.deepPurple],
              _deviceHeight,
              UploadDocsRoute()
            ),
          ],
        ),
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
    return Container();
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
