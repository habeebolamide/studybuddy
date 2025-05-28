import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studybuddy/routes/app_router.dart';
import 'package:studybuddy/screens/components/dashboard.dart';
import 'package:studybuddy/screens/components/profile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:studybuddy/screens/components/notes.dart';

@RoutePage()
class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [DashboardRoute(), StudyNotesRoute(), ProfileRoute()],

      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          backgroundColor: const Color(0xFFF6F5FF),

          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            selectedItemColor: const Color(0xFF6D3EDD),
            unselectedItemColor: Colors.grey,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.book),
                label: 'StudyNotes',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
    // Scaffold(
    //   backgroundColor:Color(0xFFF6F5FF),
    //   body: _pages[_selectedIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     currentIndex: _selectedIndex,
    //     selectedItemColor:Color(0xFF6D3EDD),
    //     unselectedItemColor: Colors.grey,
    //     onTap: _onItemTapped,
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.house),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.book),
    //         label: 'StudyNotes',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.user),
    //         label: 'Profile',
    //       ),
    //     ],
    //   ),
    // );
  }
}
