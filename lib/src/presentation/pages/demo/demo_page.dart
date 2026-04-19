import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../config/theme.dart';
import '../../widgets/sections/ar_preview_section.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> sections = [
      {
        'title': 'Discover Nearby',
        'text': 'Find restaurants around you instantly.',
        'image': 'assets/media/demo1.png',
      },
      {
        'title': 'Explore Options',
        'text': 'Browse places with menus, tags, and ratings.',
        'image': 'assets/media/demo2.png',
      },
      {
        'title': 'See Before You Go',
        'text': 'View full details and menus in one place.',
        'image': 'assets/media/demo3.png',
      },
      {
        'title': 'Earn Cashback',
        'text': 'Scan QR and get rewards instantly.',
        'image': 'assets/media/demo4.png',
      },
      {
        'title': 'Real Value',
        'text': 'Every visit brings benefits back to you.',
        'image': 'assets/media/demo5.png',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        children: [
          const Text(
            'Product Demo',
            style: TextStyle(
              color: AppTheme.textWhite,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 100),

          // Walkthrough Sections
          ...List.generate(sections.length, (index) {
            final section = sections[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 120.0),
              child: ProductDemoSection(
                title: section['title']!,
                text: section['text']!,
                imagePath: section['image']!,
                isLeft: index % 2 == 0,
              ),
            );
          }),

          // AR Feature Teaser
          const SizedBox(height: 120),
          const ArPreviewSection(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class ProductDemoSection extends StatefulWidget {
  final String title;
  final String text;
  final String imagePath;
  final bool isLeft;

  const ProductDemoSection({
    super.key,
    required this.title,
    required this.text,
    required this.imagePath,
    required this.isLeft,
  });

  @override
  State<ProductDemoSection> createState() => _ProductDemoSectionState();
}

class _ProductDemoSectionState extends State<ProductDemoSection> {
  double _opacity = 0;
  double _translateY = 30;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('section_${widget.title}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          if (mounted) {
            setState(() {
              _opacity = 1;
              _translateY = 0;
            });
          }
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        opacity: _opacity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _translateY, 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 800;

              if (isMobile) {
                return Column(
                  children: [
                    _buildText(textAlign: TextAlign.center),
                    const SizedBox(height: 48),
                    _buildImage(),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLeft) ...[
                    Expanded(child: _buildText(textAlign: TextAlign.right)),
                    const SizedBox(width: 80),
                    Expanded(child: _buildImage()),
                  ] else ...[
                    Expanded(child: _buildImage()),
                    const SizedBox(width: 80),
                    Expanded(child: _buildText(textAlign: TextAlign.left)),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildText({required TextAlign textAlign}) {
    return Column(
      crossAxisAlignment:
          textAlign == TextAlign.right ? CrossAxisAlignment.end : (textAlign == TextAlign.left ? CrossAxisAlignment.start : CrossAxisAlignment.center),
      children: [
        Text(
          widget.title,
          textAlign: textAlign,
          style: const TextStyle(
            color: AppTheme.textWhite,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.text,
          textAlign: textAlign,
          style: const TextStyle(
            color: AppTheme.textLightGray,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Center(
      child: MobilePhoneFrame(
        imagePath: widget.imagePath,
      ),
    );
  }
}

class MobilePhoneFrame extends StatefulWidget {
  final String imagePath;

  const MobilePhoneFrame({super.key, required this.imagePath});

  @override
  State<MobilePhoneFrame> createState() => _MobilePhoneFrameState();
}

class _MobilePhoneFrameState extends State<MobilePhoneFrame> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        scale: _isHovered ? 1.05 : 1.0,
        curve: Curves.easeOutBack,
        child: Container(
          width: 250,
          height: 540,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(42),
            border: Border.all(color: const Color(0xFF2C2C2E), width: 4),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withAlpha(50),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                // App Screenshot
                Positioned.fill(
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF1C1C1E),
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.white24, size: 40),
                        ),
                      );
                    },
                  ),
                ),
                // Device Gloss/Reflections
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withAlpha(20),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ),
                // Notch
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 80,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
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
