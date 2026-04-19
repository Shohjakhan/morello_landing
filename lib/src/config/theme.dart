import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF0B0B0F);
  static const Color primary = Color(0xFF8B1E3F);
  static const Color accent = Color(0xFFD9746F);
  static const Color textWhite = Colors.white;
  static const Color textLightGray = Color(0xFFB3B3B3);
  static const Color glassBorder = Color(0x1AFFFFFF); // rgba(255,255,255,0.1)

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: background,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme.copyWith(
          bodyLarge: const TextStyle(color: textWhite),
          bodyMedium: const TextStyle(color: textLightGray),
          displayLarge: const TextStyle(color: textWhite, fontWeight: FontWeight.bold),
          displayMedium: const TextStyle(color: textWhite, fontWeight: FontWeight.bold),
          titleLarge: const TextStyle(color: textWhite, fontWeight: FontWeight.w600),
        ),
      ),
      useMaterial3: true,
    );
  }
}
