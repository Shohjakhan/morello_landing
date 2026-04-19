import 'package:flutter/material.dart';
import 'home/home_page.dart';
import 'solution/solution_page.dart';
import 'team/team_page.dart';
import 'roadmap/roadmap_page.dart';
import 'demo/demo_page.dart';
import '../widgets/layout/app_layout.dart';
import '../widgets/sections/problem_section.dart';

class MainLandingPage extends StatefulWidget {
  // Static key so Navbar (a sibling in AppLayout's Stack) can reach this state
  static final globalKey = GlobalKey<MainLandingPageState>();

  const MainLandingPage({super.key});

  @override
  State<MainLandingPage> createState() => MainLandingPageState();

  static MainLandingPageState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<MainLandingPageState>();
  }
}

class MainLandingPageState extends State<MainLandingPage> {
  final ScrollController scrollController = ScrollController();
  
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey problemKey = GlobalKey();
  final GlobalKey solutionKey = GlobalKey();
  final GlobalKey teamKey = GlobalKey();
  final GlobalKey roadmapKey = GlobalKey();
  final GlobalKey demoKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Container(key: homeKey, child: const HomePage()),
          Container(key: problemKey, child: const ProblemSection()),
          Container(key: solutionKey, child: const SolutionPage()),
          Container(key: teamKey, child: const TeamPage()),
          Container(key: roadmapKey, child: const RoadmapPage()),
          Container(key: demoKey, child: const DemoPage()),
          const SizedBox(height: 100), // extra scrolling room
        ],
      ),
    );
  }
}
