import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      backgroundColor: Colors.white,
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
                image: 'assets/stu1.jpg',
                title: "Personalized Learning Goals",
                description: "Set your own academic goals and track your daily progress effortlessly.",
              ),
              buildPage(
                image: 'assets/schedule.jpg',
                title: "Organized Study Scheduler",
                description: "Plan smarter with a visual calendar that keeps your study time structured and efficient.",
              ),
              buildPage(
                image: 'assets/student.png',
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
                effect: WormEffect(dotColor: Colors.grey, activeDotColor: Colors.pink),
              ),
            ),
          ),

          // Skip Button
          Positioned(
            bottom: 30,
            left: 20,
            child: GestureDetector(
              onTap: () => _controller.jumpToPage(2),
              child: Text("Skip", style: TextStyle(color: Colors.pink)),
            ),
          ),

          // Next or Sign up Button
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
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
              child: Text(onLastPage ? "Sign up" : "Next"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({required String image, required String title, required String description}) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(

              ),
          ),
          Image.asset(image, height: 500),
          SizedBox(height: 40),
          Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black)),
          SizedBox(height: 20),
          Text(description, textAlign: TextAlign.center, style: TextStyle(color: Colors.pink),),
        ],
      ),
    );
  }
}
