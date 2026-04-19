import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../config/theme.dart';
import '../glass/glass_container.dart';
import '../animations/hover_scale_glow.dart';

class ProblemSection extends StatefulWidget {
  const ProblemSection({super.key});

  @override
  State<ProblemSection> createState() => _ProblemSectionState();
}

class _ProblemSectionState extends State<ProblemSection> {
  final List<bool> _isVisible = [false, false, false, false];
  bool _hasStarted = false;

  void _startAnimations() async {
    if (_hasStarted) return;
    _hasStarted = true;
    for (int i = 0; i < _isVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _isVisible[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('problem-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2) {
          _startAnimations();
        }
      },
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppTheme.primary.withAlpha(50)),
                ),
                child: const Text(
                  'THE PROBLEM',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                'The Problem',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Dining decisions are still broken',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 20,
                      color: AppTheme.textLightGray,
                    ),
              ),
              const SizedBox(height: 64),

              // Creative Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 1000;
                  final isMedium = constraints.maxWidth > 700;
                  
                  return GridView.count(
                    crossAxisCount: isWide ? 4 : (isMedium ? 2 : 1),
                    childAspectRatio: isWide ? 260 / 300 : (isMedium ? 1.2 : 1.5),
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildProblemCard(
                        0,
                        icon: Icons.image_not_supported_outlined,
                        title: 'Unclear Choices',
                        text: 'Photos don’t match reality, leading to disappointing meals.',
                        accentColor: const Color(0xFFE57373),
                      ),
                      _buildProblemCard(
                        1,
                        icon: Icons.layers_outlined,
                        title: 'Scattered Info',
                        text: 'Menus, ratings, and locations are spread across multiple apps.',
                        accentColor: const Color(0xFF90A4AE),
                      ),
                      _buildProblemCard(
                        2,
                        icon: Icons.visibility_off_outlined,
                        title: 'Low Visibility',
                        text: 'Amazing local restaurants stay hidden behind poor marketing.',
                        accentColor: const Color(0xFFD32F2F),
                      ),
                      _buildProblemCard(
                        3,
                        icon: Icons.redeem_outlined,
                        title: 'No Incentive',
                        text: 'Users gain nothing for stepping out and trying new places.',
                        accentColor: const Color(0xFFF06292),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProblemCard(
    int index, {
    required IconData icon,
    required String title,
    required String text,
    required Color accentColor,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: _isVisible[index] ? 1.0 : 0.0,
      curve: Curves.easeOut,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 600),
        offset: _isVisible[index] ? Offset.zero : const Offset(0, 0.1),
        curve: Curves.easeOut,
        child: HoverScaleGlow(
          scale: 1.05,
          glowColor: accentColor.withAlpha(60),
          child: GlassContainer(
            borderRadius: 32,
            padding: const EdgeInsets.all(32),
            blur: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon with glowing background
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(40),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withAlpha(30),
                        blurRadius: 15,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Icon(icon, size: 28, color: accentColor),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textWhite,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textWhite.withAlpha(180),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
