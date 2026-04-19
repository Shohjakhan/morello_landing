import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../config/theme.dart';
import '../glass/glass_container.dart';
import '../animations/hover_scale_glow.dart';

class SolutionSection extends StatefulWidget {
  const SolutionSection({super.key});

  @override
  State<SolutionSection> createState() => _SolutionSectionState();
}

class _SolutionSectionState extends State<SolutionSection> {
  final List<bool> _isVisible = [false, false, false, false];
  bool _hasStarted = false;

  void _startAnimations() async {
    if (_hasStarted) return;
    _hasStarted = true;
    for (int i = 0; i < _isVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
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
      key: const Key('solution-section'),
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
                  color: AppTheme.accent.withAlpha(30),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppTheme.accent.withAlpha(50)),
                ),
                child: const Text(
                  'THE SOLUTION',
                  style: TextStyle(
                    color: AppTheme.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                'Reimagining Discovery',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Experience food before you even step inside',
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
                      _buildSolutionCard(
                        0,
                        icon: Icons.explore_outlined,
                        title: 'Smart Discovery',
                        text: 'Find exactly what you crave with nearby visual previews.',
                        accentColor: const Color(0xFF4CAF50), // Green for discovery
                      ),
                      _buildSolutionCard(
                        1,
                        icon: Icons.menu_book_outlined,
                        title: 'Total Transparency',
                        text: 'Access real menus, verified ratings, and live locations.',
                        accentColor: const Color(0xFF2196F3), // Blue for information
                      ),
                      _buildSolutionCard(
                        2,
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Earn & Save',
                        text: 'Get 5–20% cashback on every visit via smart QR rewards.',
                        accentColor: const Color(0xFFFFC107), // Amber for rewards
                      ),
                      _buildSolutionCard(
                        3,
                        icon: Icons.view_in_ar_outlined,
                        title: 'AR Food Preview',
                        text: 'See your meal in 3D before ordering with immersive AR.',
                        accentColor: const Color(0xFF9C27B0), // Purple for AR/Tech
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

  Widget _buildSolutionCard(
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
