import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../widgets/glass/glass_container.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
        child: Column(
          children: [
            const Text(
              'Jamoa',
              style: TextStyle(
                color: AppTheme.textWhite,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 60),

            // Team Members Layout
            Center(
              child: Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: const [
                  _TeamMemberCard(
                    name: 'Aslbek Boyxo\'rozov',
                    role: 'CO-FOUNDER - CTO',
                    points: [
                      '3+ yillik dasturlashda tajriba',
                      'Algoverse AI Scholar',
                      'PTA\'25 finalist',
                      'StartupGarage residenti',
                    ],
                    imagePath: 'assets/media/team1.png',
                  ),
                  _TeamMemberCard(
                    name: 'Shohjahon Abduhamidov',
                    role: 'FOUNDER - CEO',
                    points: [
                      '2+ yillik marketing and sales bo\'yicha tajriba',
                      'IT Community of Uzbekistan core team',
                      'PTA\'25 finalist',
                      'StartupGarage residenti',
                    ],
                    imagePath: 'assets/media/team2.png',
                  ),
                  _TeamMemberCard(
                    name: 'Bobir Abdukhalilov',
                    role: 'ADVISER - SALES',
                    points: [
                      '7+ yillik mobil dasturlashda tajriba',
                      '5+ katta loyihalarda ishlagan',
                    ],
                    imagePath: 'assets/media/team3.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final List<String> points;
  final String? imagePath;

  const _TeamMemberCard({
    required this.name,
    required this.role,
    required this.points,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 340,
      padding: const EdgeInsets.all(32),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: AppTheme.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppTheme.glassBorder, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => const Icon(
                        Icons.person_outline,
                        color: AppTheme.textLightGray,
                        size: 56,
                      ),
                    )
                  : const Icon(
                      Icons.person_outline,
                      color: AppTheme.textLightGray,
                      size: 56,
                    ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Name / Title
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),

          // Role
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accent.withAlpha(40),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              role,
              style: const TextStyle(
                color: AppTheme.accent,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Achievements/Points
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppTheme.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        color: AppTheme.textLightGray,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
