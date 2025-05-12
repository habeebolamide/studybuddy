import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const Color primaryColor = Color(0xFF6C3DFF); // Purple
const Color accentPink = Color(0xFFFF4FD8);   // Pink
const Color accentBlue = Color(0xFF3DBEFF);   // Blue
const Color backgroundColor = Color(0xFFF9F9FB);
const Color darkTextColor = Color(0xFF1C1C2E);

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                image: 'assets/Personalized.png',
                title: "Personalized Learning Goals",
                description: "Set your own academic goals and track your daily progress effortlessly.",
              ),
              buildPage(
                image: 'assets/Scheduler.jpg',
                title: "Organized Study Scheduler",
                description: "Plan smarter with a visual calendar that keeps your study time structured and efficient.",
              ),
              buildPage(
                image: 'assets/AI.jpg',
                title: "Chat with Your AI Tutor",
                description: "Get instant help, summaries, and quizzes from your smart study assistant.",
              ),
            ],
          ),

          // Dot indicator
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotColor: Colors.grey.shade300,
                  activeDotColor: primaryColor,
                ),
              ),
            ),
          ),

          // Skip Button
          Positioned(
            bottom: 30,
            left: 20,
            child: GestureDetector(
              onTap: () => _controller.jumpToPage(2),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: accentBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Next or Sign up Button
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (onLastPage) {
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(
                onLastPage ? "Sign up" : "Next",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 360),
          SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: darkTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
