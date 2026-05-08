import 'package:flutter/material.dart';

class AppTheme {
  // Colors

  static const Color background = Color(0xFFF8F7F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFD4621A);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color border = Color(0xFFE8E6E1);

  // Typography

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  // ThemeData

  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.light(primary: accent, surface: surface),
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      titleTextStyle: heading,
    ),
  );
}
