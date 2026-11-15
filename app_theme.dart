import 'package:flutter/material.dart';

/// Farbpalette: ruhiges Dunkelgrün mit Goldakzenten.
class AppColors {
  AppColors._();

  static const Color deepGreen = Color(0xFF0B3B2E);
  static const Color green = Color(0xFF145A45);
  static const Color darkestGreen = Color(0xFF072920);
  static const Color cardGreen = Color(0xFF124A3A);
  static const Color gold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFF1DFA6);
  static const Color cream = Color(0xFFF7F1E1);

  /// Creme mit ca. 70 % Deckkraft – für Nebentexte.
  static const Color muted = Color(0xB3F7F1E1);

  /// Gold mit ca. 20 % Deckkraft – Hintergrund von Fortschrittsbalken/Ring.
  static const Color track = Color(0x33F1DFA6);

  /// Gold mit ca. 25 % Deckkraft – dezente Rahmen.
  static const Color goldBorder = Color(0x40D4AF37);
}

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.gold,
      onPrimary: AppColors.deepGreen,
      secondary: AppColors.lightGold,
      surface: AppColors.deepGreen,
      onSurface: AppColors.cream,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.deepGreen,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightGold,
          side: const BorderSide(color: AppColors.goldBorder),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.deepGreen,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.lightGold),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.cardGreen,
        contentTextStyle: TextStyle(color: AppColors.cream),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
