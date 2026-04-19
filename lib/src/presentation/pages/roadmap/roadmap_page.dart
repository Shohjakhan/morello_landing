import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../config/theme.dart';
import '../../widgets/glass/glass_container.dart';
import '../../widgets/animations/hover_scale_glow.dart';

class RoadmapPage extends StatelessWidget {
  const RoadmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Momentum
            Text(
              'Momentum',
              style: TextStyle(
                color: AppTheme.textWhite,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            _MomentumCards(),

            SizedBox(height: 100),

            // Section 2: Progress Line
            _ProgressLineSection(),

            SizedBox(height: 100),

            // Section 3: Next
            Text(
              'Next',
              style: TextStyle(
                color: AppTheme.textWhite,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            _NextCards(),
            
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _MomentumCards extends StatelessWidget {
  const _MomentumCards();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _MomentumCard(text: 'MVP Ready')),
        SizedBox(width: 24),
        Expanded(child: _MomentumCard(text: '5 Partners Secured')),
        SizedBox(width: 24),
        Expanded(child: _MomentumCard(text: 'Launch — May 2026')),
      ],
    );
  }
}

class _MomentumCard extends StatelessWidget {
  final String text;
  const _MomentumCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return HoverScaleGlow(
      scale: 1.03,
      glowColor: AppTheme.accent.withAlpha(40),
      child: GlassContainer(
        height: 140,
        borderRadius: 24,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressLineSection extends StatefulWidget {
  const _ProgressLineSection();

  @override
  State<_ProgressLineSection> createState() => _ProgressLineSectionState();
}

class _ProgressLineSectionState extends State<_ProgressLineSection> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late AnimationController _pulseController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 0.62).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOutCubic),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('progress-line-visibility'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
          _progressController.forward();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background Line
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.glassBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Animated Progress Line
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.accent,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accent.withAlpha(100),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            // Steps
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ProgressStep(
                  label: 'MVP Built',
                  status: StepStatus.completed,
                ),
                _ProgressStep(
                  label: 'Partners Onboarded',
                  status: StepStatus.completed,
                ),
                _ProgressStep(
                  label: 'Launch',
                  status: StepStatus.active,
                ),
                _ProgressStep(
                  label: 'Scale',
                  status: StepStatus.upcoming,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum StepStatus { completed, active, upcoming }

class _ProgressStep extends StatelessWidget {
  final String label;
  final StepStatus status;

  const _ProgressStep({
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    bool isPulse = false;
    double opacity = 1.0;

    switch (status) {
      case StepStatus.completed:
        color = AppTheme.accent;
        break;
      case StepStatus.active:
        color = AppTheme.accent;
        isPulse = true;
        break;
      case StepStatus.upcoming:
        color = AppTheme.textLightGray;
        opacity = 0.4;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          child: Center(
            child: isPulse ? const _PulseDot() : Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: status == StepStatus.completed ? [
                   BoxShadow(color: color.withAlpha(100), blurRadius: 8)
                ] : null,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Opacity(
          opacity: opacity,
          child: Text(
            label,
            style: TextStyle(
              color: AppTheme.textWhite,
              fontSize: 14,
              fontWeight: status == StepStatus.active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: AppTheme.accent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.accent.withAlpha((150 * (1 - _controller.value)).toInt()),
                blurRadius: 15 * _controller.value,
                spreadRadius: 10 * _controller.value,
              )
            ],
          ),
        );
      },
    );
  }
}

class _NextCards extends StatelessWidget {
  const _NextCards();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _NextCard(text: 'Expansion to major cities')),
        SizedBox(width: 24),
        Expanded(child: _NextCard(text: '100+ restaurants')),
        SizedBox(width: 24),
        Expanded(child: _NextCard(text: 'Nationwide rollout')),
      ],
    );
  }
}

class _NextCard extends StatelessWidget {
  final String text;
  const _NextCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return HoverScaleGlow(
      scale: 1.03,
      glowColor: AppTheme.primary.withAlpha(30),
      child: GlassContainer(
        height: 100,
        borderRadius: 20,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
