import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../navbar/navbar.dart';

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Ambient top-left glow
          Positioned(
            top: -120,
            left: -100,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(60),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),
          // Ambient bottom-right glow
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accent.withAlpha(50),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),

          // Page content — full height, scrollable from 112px top
          Positioned.fill(
            top: 112,
            child: child,
          ),

          // Sticky navbar on top
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }
}
