import 'package:flutter/material.dart';
import '../../widgets/sections/hero_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: HeroSection(),
    );
  }
}
