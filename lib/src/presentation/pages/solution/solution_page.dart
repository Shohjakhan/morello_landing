import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../widgets/sections/solution_section.dart';
import '../../widgets/sections/ecosystem_diagram.dart';

class SolutionPage extends StatelessWidget {
  const SolutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SolutionSection(),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 60.0,
            ),
            child: Column(
              children: [
                const _HighlightText(),
                const SizedBox(height: 100),

                // Ecosystem Section
                const Text(
                  'Ecosystem',
                  style: TextStyle(
                    color: AppTheme.textWhite,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 20),

                // The Visual System Diagram
                const EcosystemDiagram(),
              ],
            ),
          ),
          const SizedBox(height: 80), // Bottom padding
        ],
      ),
    );
  }
}

class _HighlightText extends StatelessWidget {
  const _HighlightText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '"We turn food discovery into a visual experience."',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.textWhite,
          fontSize: MediaQuery.of(context).size.width > 600 ? 40 : 28,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          letterSpacing: -0.5,
          height: 1.3,
        ),
      ),
    );
  }
}
