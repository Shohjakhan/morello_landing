import 'package:flutter/material.dart';

class HoverScaleGlow extends StatefulWidget {
  final Widget child;
  final double scale;
  final Color glowColor;
  final double glowSpread;
  final double glowBlur;

  const HoverScaleGlow({
    super.key,
    required this.child,
    this.scale = 1.03,
    required this.glowColor,
    this.glowSpread = 4.0,
    this.glowBlur = 20.0,
  });

  @override
  State<HoverScaleGlow> createState() => _HoverScaleGlowState();
}

class _HoverScaleGlowState extends State<HoverScaleGlow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(_isHovered ? widget.scale : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), // Approx fitting most cards
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.glowColor,
                spreadRadius: widget.glowSpread,
                blurRadius: widget.glowBlur,
              ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
