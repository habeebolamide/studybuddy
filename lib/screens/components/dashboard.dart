import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _topLayerWidget(),
            _dashboardActions()
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
                "Welcome\nJames!",
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
            _dashboardCard(FontAwesomeIcons.upload, "Upload", [
              Color(0xFF6D3EDD),
              Color(0xFFF052C6),
            ], _deviceHeight,'/create'),
            _dashboardCard(FontAwesomeIcons.book, "Create", [
              Colors.blue,
              Colors.blue,
            ], _deviceHeight,'/create'),
            _dashboardCard(FontAwesomeIcons.brain, "Quiz", [
              Colors.deepPurple,
              Colors.deepPurple,
            ], _deviceHeight,'/create'),
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
    String Url
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
            Navigator.pushNamed(
                      context,
                      Url
                    );
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
}
