import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentBlue,
        secondary: AppColors.accentGreen,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textLightPrimary,
      ),
      textTheme: base.textTheme.copyWith(
        displayLarge: const TextStyle(color: AppColors.textLightPrimary, fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(color: AppColors.textLightPrimary, fontWeight: FontWeight.w600),
        bodyLarge: const TextStyle(color: AppColors.textLightPrimary),
        bodyMedium: const TextStyle(color: AppColors.textLightSecondary),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textLightPrimary,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textLightPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColors.surfaceLight,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.accentBlue,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.accentBlue,
        unselectedItemColor: AppColors.textLightSecondary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentBlue, // Keeping accentBlue as primary for consistency, or primaryNight for "Night mode" feel? 
        // User said "new dark theme color", maybe they want the blue? 
        // Let's use accentBlue but maybe a bit muted if needed. Actually accentBlue is already premium.
        secondary: AppColors.accentGreen,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textDarkPrimary,
        primaryContainer: AppColors.surfaceDark,
      ),
      textTheme: base.textTheme.copyWith(
        displayLarge: const TextStyle(color: AppColors.textDarkPrimary, fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(color: AppColors.textDarkPrimary, fontWeight: FontWeight.w600),
        bodyLarge: const TextStyle(color: AppColors.textDarkPrimary),
        bodyMedium: const TextStyle(color: AppColors.textDarkSecondary),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDarkPrimary,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textDarkPrimary),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColors.surfaceDark,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        modalBackgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.accentBlue,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.accentBlue,
        unselectedItemColor: AppColors.textDarkSecondary,
        type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: AppColors.textDarkSecondary),
        prefixIconColor: AppColors.textDarkSecondary,
      ),
    );
  }
}
