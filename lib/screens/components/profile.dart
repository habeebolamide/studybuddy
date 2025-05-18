import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: _dashboardActions(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _topLayerWidget() {
    return SizedBox(
      height: _deviceHeight * 0.45,
      width: _deviceWidth,

      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D3EDD), Color(0xFFF052C6)],
          ),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(45.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF6D3EDD)),
              ),
              Text(
                "Jane Doe \nHa",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
