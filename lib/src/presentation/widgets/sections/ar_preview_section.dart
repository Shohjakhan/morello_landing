import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../config/theme.dart';

class ArPreviewSection extends StatefulWidget {
  const ArPreviewSection({super.key});

  @override
  State<ArPreviewSection> createState() => _ArPreviewSectionState();
}

class _ArPreviewSectionState extends State<ArPreviewSection>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final AnimationController _floatController;
  late final Animation<double> _glowAnimation;
  late final Animation<double> _floatAnimation;
  double _opacity = 0;
  double _translateY = 40;

  @override
  void initState() {
    super.initState();

    // Slow pulsing glow
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);

    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );

    // Subtle floating for badges
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat(reverse: true);

    _floatAnimation = CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('ar_preview_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && mounted) {
          setState(() {
            _opacity = 1;
            _translateY = 0;
          });
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        opacity: _opacity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _translateY, 0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Column(
                children: [
                  // "Coming Soon" label
                  Text(
                    'COMING SOON',
                    style: TextStyle(
                      color: AppTheme.accent.withAlpha(160),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Main title
                  const Text(
                    'AR Food Preview',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  const Text(
                    'See your food before you order.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textLightGray,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Main glass preview box with floating badges
                  _buildPreviewBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewBox() {
    return AnimatedBuilder(
      animation: Listenable.merge([_glowAnimation, _floatAnimation]),
      builder: (context, child) {
        final glowIntensity = _glowAnimation.value;
        final floatOffset = math.sin(_floatController.value * math.pi) * 6;

        return SizedBox(
          height: 500,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Ambient glow behind box
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: 420,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accent.withAlpha(
                            (30 + glowIntensity * 45).toInt()),
                        blurRadius: 60 + glowIntensity * 40,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: AppTheme.primary.withAlpha(
                            (20 + glowIntensity * 30).toInt()),
                        blurRadius: 80 + glowIntensity * 30,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),

              // Main glass container
              Positioned(
                child: _buildGlassContainer(glowIntensity),
              ),

              // Floating badge: "3D View" — top left
              Positioned(
                top: 20 - floatOffset * 0.8,
                left: 16,
                child: _buildBadge('3D View', Icons.view_in_ar_rounded),
              ),

              // Floating badge: "Live Preview" — bottom right
              Positioned(
                bottom: 20 + floatOffset,
                right: 16,
                child: _buildBadge('Live Preview', Icons.visibility_rounded),
              ),

              // Floating badge: "In Progress" — top right
              Positioned(
                top: 60 + floatOffset * 0.5,
                right: 0,
                child: _buildBadge(
                  'In Progress',
                  Icons.construction_rounded,
                  accent: AppTheme.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlassContainer(double glowIntensity) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 420,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppTheme.accent.withAlpha(
                  (40 + glowIntensity * 40).toInt()),
              width: 1.2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withAlpha(18),
                AppTheme.accent.withAlpha((8 + glowIntensity * 10).toInt()),
                Colors.white.withAlpha(5),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Placeholder image or fallback icon
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/media/ar_preview.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        _buildFallbackContent(glowIntensity),
                  ),
                ),
              ),

              // Shimmer overlay
              Positioned.fill(
                child: _buildShimmerOverlay(glowIntensity),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackContent(double glowIntensity) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xFF0D0D12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.view_in_ar_rounded,
            size: 72,
            color: AppTheme.accent.withAlpha(
                (80 + glowIntensity * 100).toInt()),
          ),
          const SizedBox(height: 16),
          Text(
            'AR Preview',
            style: TextStyle(
              color: AppTheme.textLightGray.withAlpha(140),
              fontSize: 16,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerOverlay(double glowIntensity) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment(-1 + glowIntensity * 0.5, -1),
          end: Alignment(1 - glowIntensity * 0.5, 1),
          colors: [
            Colors.white.withAlpha((12 + glowIntensity * 15).toInt()),
            Colors.transparent,
            Colors.transparent,
            Colors.white.withAlpha((5 + glowIntensity * 8).toInt()),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, IconData icon, {Color? accent}) {
    final color = accent ?? AppTheme.accent;
    final floatVal = math.sin(_floatController.value * math.pi);

    return Transform.translate(
      offset: Offset(0, floatVal * 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color.withAlpha(25),
              border: Border.all(color: color.withAlpha(60), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
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
