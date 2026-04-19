import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme.dart';
import '../../pages/main_landing_page.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24,
          vertical: 60,
        ),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 5,
                      child: _TextContent(fadeIn: _fadeIn, slideIn: _slideIn)),
                  const SizedBox(width: 60),
                  Expanded(flex: 5, child: _HeroImage(fadeIn: _fadeIn)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _TextContent(fadeIn: _fadeIn, slideIn: _slideIn),
                  const SizedBox(height: 48),
                  _HeroImage(fadeIn: _fadeIn),
                ],
              ),
      ),
    );
  }
}

class _TextContent extends StatelessWidget {
  final Animation<double> fadeIn;
  final Animation<Offset> slideIn;

  const _TextContent({required this.fadeIn, required this.slideIn});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeIn,
      child: SlideTransition(
        position: slideIn,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primary.withAlpha(51),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppTheme.primary.withAlpha(100)),
              ),
              child: const Text(
                '🍽  Restaurant Discovery & Cashback',
                style: TextStyle(
                  color: AppTheme.accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Title
            const Text(
              'Tap. Sit. Savor.',
              style: TextStyle(
                color: AppTheme.textWhite,
                fontSize: 64,
                fontWeight: FontWeight.w800,
                height: 1.1,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Subtitle
            const Text(
              'Discover restaurants, explore menus, and earn cashback in one seamless experience.',
              style: TextStyle(
                color: AppTheme.textLightGray,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 44),

            // Buttons
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _PrimaryButton(
                  label: 'View Demo',
                  onTap: () => context.go('/demo'),
                ),
                _OutlineButton(
                  label: 'Explore Platform',
                  onTap: () {
                    final s = MainLandingPage.globalKey.currentState;
                    if (s != null) s.scrollToSection(s.solutionKey);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final Animation<double> fadeIn;

  const _HeroImage({required this.fadeIn});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeIn,
      child: Center(
        child: Image.asset(
          'assets/media/hero.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stack) => Container(
            height: 420,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white.withAlpha(8),
              border: Border.all(color: AppTheme.glassBorder),
            ),
            child: const Center(
              child: Text(
                '[ App Preview ]',
                style: TextStyle(color: AppTheme.textLightGray, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.accent : AppTheme.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppTheme.accent.withAlpha(100),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({required this.label, required this.onTap});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          decoration: BoxDecoration(
            color: _hovered ? Colors.white.withAlpha(20) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? Colors.white.withAlpha(100)
                  : AppTheme.glassBorder,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovered ? AppTheme.textWhite : AppTheme.textLightGray,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
