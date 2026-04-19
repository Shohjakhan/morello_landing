import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme.dart';
import '../glass/glass_container.dart';
import '../../pages/main_landing_page.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  // Resolves state via globalKey (works even when Navbar is a sibling in Stack)
  MainLandingPageState? get _mainState => MainLandingPage.globalKey.currentState;

  void _scrollTo(GlobalKey key) {
    _mainState?.scrollToSection(key);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: GlassContainer(
        height: 80,
        borderRadius: 24,
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo — scrolls to top or navigates home
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  final s = _mainState;
                  if (s != null) {
                    _scrollTo(s.homeKey);
                  } else {
                    context.go('/');
                  }
                },
                child: Image.asset(
                  'assets/media/logo.png',
                  height: 44,
                  errorBuilder: (context, error, stack) => const Text(
                    'Moreva',
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),

            // Nav links
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavButton(
                  title: 'Home',
                  onTap: () {
                    final s = _mainState;
                    if (s != null) _scrollTo(s.homeKey);
                    else context.go('/');
                  },
                ),
                _NavButton(
                  title: 'Problem',
                  onTap: () {
                    final s = _mainState;
                    if (s != null) _scrollTo(s.problemKey);
                    else context.go('/');
                  },
                ),
                _NavButton(
                  title: 'Solution',
                  onTap: () {
                    final s = _mainState;
                    if (s != null) _scrollTo(s.solutionKey);
                    else context.go('/');
                  },
                ),
                _NavButton(
                  title: 'Team',
                  onTap: () {
                    final s = _mainState;
                    if (s != null) _scrollTo(s.teamKey);
                    else context.go('/');
                  },
                ),
                _NavButton(
                  title: 'Roadmap',
                  onTap: () {
                    final s = _mainState;
                    if (s != null) _scrollTo(s.roadmapKey);
                    else context.go('/');
                  },
                ),
                _NavButton(
                  title: 'Demo',
                  onTap: () {
                    final s = _mainState;
                    if (s != null) {
                      _scrollTo(s.demoKey);
                    } else {
                      context.go('/demo');
                    }
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

class _NavButton extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;

  const _NavButton({required this.title, this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isHovered ? AppTheme.textWhite : AppTheme.textLightGray,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 16,
                ),
                child: Text(widget.title),
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isHovered ? 1.0 : 0.0,
                child: Container(
                  width: 24,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppTheme.accent,
                    borderRadius: BorderRadius.circular(1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accent.withAlpha(100),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
