import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../widgets/glass/glass_container.dart';
import '../../widgets/animations/hover_scale_glow.dart';

class ProblemPage extends StatefulWidget {
  const ProblemPage({super.key});

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  final List<bool> _isVisible = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() async {
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
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Section
              Text(
                'The Problem',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Dining decisions are still broken',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  color: AppTheme.textLightGray,
                ),
              ),
              const SizedBox(height: 64),

              // Grid
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width < 800 ? 1 : 2,
                childAspectRatio: MediaQuery.of(context).size.width < 800
                    ? 1.5
                    : 1100 / (2 * 300),
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildAnimatedCard(
                    0,
                    icon: 'assets/media/problem1.png',
                    title: 'Unclear Choices',
                    text: 'Photos don’t match reality',
                  ),
                  _buildAnimatedCard(
                    1,
                    icon: 'assets/media/problem2.png',
                    title: 'Scattered Information',
                    text: 'Menus, ratings, location — everywhere',
                  ),
                  _buildAnimatedCard(
                    2,
                    icon: 'assets/media/problem3.png',
                    title: 'Low Restaurant Visibility',
                    text: 'Good places stay hidden',
                  ),
                  _buildAnimatedCard(
                    3,
                    icon: 'assets/media/problem4.png',
                    title: 'No Incentive to Explore',
                    text: 'Users gain nothing for trying new places',
                  ),
                ],
              ),
              const SizedBox(height: 100), // Extra space at bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(
    int index, {
    required String icon,
    required String title,
    required String text,
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
          scale: 1.04,
          glowColor: AppTheme.primary.withAlpha(40),
          child: GlassContainer(
            height: 240,
            borderRadius: 28,
            padding: const EdgeInsets.all(28),
            blur: 20,
            child: Stack(
              children: [
                // Subtle red tint overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.red.withAlpha(
                        10,
                      ), // Very subtle red overlay
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      icon,
                      width: 64,
                      height: 64,
                      errorBuilder: (context, error, stack) => Container(
                        width: 64,
                        height: 64,
                        color: AppTheme.primary.withAlpha(30),
                        child: const Icon(Icons.broken_image, size: 32),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
