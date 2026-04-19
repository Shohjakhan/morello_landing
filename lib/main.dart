import 'package:flutter/material.dart';
import 'src/config/theme.dart';
import 'src/config/router.dart';
import 'src/presentation/pages/main_landing_page.dart';

void main() {
  runApp(const MorevaApp());
}

class MorevaApp extends StatelessWidget {
  const MorevaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Moreva',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
