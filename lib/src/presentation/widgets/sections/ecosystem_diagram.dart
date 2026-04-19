import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../glass/glass_container.dart';
import '../animations/hover_scale_glow.dart';

class EcosystemDiagram extends StatefulWidget {
  const EcosystemDiagram({super.key});

  @override
  State<EcosystemDiagram> createState() => _EcosystemDiagramState();
}

class _EcosystemDiagramState extends State<EcosystemDiagram> with TickerProviderStateMixin {
  late AnimationController _lineController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _lineController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Math for perfectly balanced circular alignment:
    const double centerX = 550; 
    const double centerY = 400; // Center of the visual circle
    const double radius = 280; // Increased radius for more space between nodes

    // To make visible wire lengths equal, we calculate angular positions.
    // Top node (Cho'ntak) is 200 wide. Side cards are 260 wide.
    // Positions at 270 (Top), 152.4 (Bottom Left), 27.6 (Bottom Right)
    // results in ~125 deg gap between bottom nodes and ~117.5 deg gaps to top node,
    // which visually balances the wider side cards vs the narrower circle node.

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        height: 800, // Increased height for the wider layout
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated Connections (Perfect Circle)
            Positioned.fill(
              child: CustomPaint(
                painter: _ConnectionPainter(
                  animationValue: _lineController,
                  centerX: centerX,
                  centerY: centerY,
                  radius: radius,
                ),
              ),
            ),

            // Node 1: Cho'ntak (Top - 270 degrees)
            // Center: (550, 400 - 280) = (550, 120)
            // top = 120 - 100 = 20
            Positioned(
              top: 20,
              left: 450,
              child: _buildCenterNode(),
            ),

            // Node 2: Users (Bottom Left - 152.4 degrees)
            // Center: (550 + 280 * cos(152.4), 400 + 280 * sin(152.4))
            // Center: (550 - 248, 400 + 130) = (302, 530)
            // left = 302 - 130 = 172, top = 530 - 100 = 430
            Positioned(
              top: 430,
              left: 172,
              child: _buildSideCard(
                'Users',
                [
                  'Discover nearby places',
                  'Explore menus visually',
                  'Earn cashback (5–10%)',
                  'Simple experience',
                ],
              ),
            ),

            // Node 3: Restaurants (Bottom Right - 27.6 degrees)
            // Center: (550 + 248, 530) = (798, 530)
            // left = 798 - 130 = 668, top = 430
            Positioned(
              top: 430,
              left: 668,
              child: _buildSideCard(
                'Restaurants',
                [
                  'Get more customers',
                  'Increase visibility',
                  'Promote offers',
                  'Notifications',
                ],
              ),
            ),

            // Connection Labels (Balanced along the larger circle)
            Positioned(
              left: 180,
              top: 240,
              child: _ConnectionLabel('Search • Explore'),
            ),
            Positioned(
              right: 180,
              top: 240,
              child: _ConnectionLabel('Traffic • Visibility'),
            ),
            Positioned(
              bottom: 80,
              child: _ConnectionLabel('Offers • Cashback'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNode() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.accent.withAlpha(40),
                blurRadius: _pulseAnimation.value,
                spreadRadius: _pulseAnimation.value / 4,
              )
            ],
          ),
          child: GlassContainer(
            borderRadius: 100,
            blur: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cho’ntak',
                  style: TextStyle(
                    color: AppTheme.textWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discovery • Cashback • Growth',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.textWhite.withAlpha(180),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSideCard(String title, List<String> points) {
    return HoverScaleGlow(
      scale: 1.03,
      glowColor: AppTheme.primary.withAlpha(40),
      child: GlassContainer(
        width: 260,
        height: 200,
        borderRadius: 24,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...points.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppTheme.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          p,
                          style: const TextStyle(
                            color: AppTheme.textLightGray,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _ConnectionLabel extends StatelessWidget {
  final String text;
  const _ConnectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppTheme.textLightGray, fontSize: 12),
      ),
    );
  }
}

class _ConnectionPainter extends CustomPainter {
  final Animation<double> animationValue;
  final double centerX;
  final double centerY;
  final double radius;

  _ConnectionPainter({
    required this.animationValue,
    required this.centerX,
    required this.centerY,
    required this.radius,
  }) : super(repaint: animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.accent.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final dashPaint = Paint()
      ..color = AppTheme.accent.withAlpha(180)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);

    // Continuous circular background line
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Dashed flow animation along the same circle
    final continuousCircle = Path()..addOval(rect);
    _drawDashedFlow(canvas, continuousCircle, dashPaint, animationValue.value);
  }

  void _drawDashedFlow(Canvas canvas, Path path, Paint paint, double progress) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      final totalLength = metric.length;
      final dashLength = 30.0;
      final gapLength = 60.0;
      
      double distance = progress * (dashLength + gapLength);
      while (distance < totalLength) {
        final extract = metric.extractPath(distance, distance + dashLength);
        canvas.drawPath(extract, paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectionPainter oldDelegate) => true;
}
