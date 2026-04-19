import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../config/theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 24.0, // 20-28
    this.blur = 25.0, // 20-30
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51), // Soft shadow (0.2)
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Smooth transition
            curve: Curves.easeInOut,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(12), // very slightly visible fill to catch light (0.05)
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: AppTheme.glassBorder,
                width: 1.0,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withAlpha(25), // 0.1
                  Colors.white.withAlpha(5),  // 0.02
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
