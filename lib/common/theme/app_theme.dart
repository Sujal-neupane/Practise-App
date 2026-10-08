import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';

/// Centralized ThemeData for the entire app.
/// Ensures consistent buttons, inputs, cards, typography, and bottom navigation.
class AppTheme {
  static const List<String> _fontFallbacks = [
    '.AppleSystemUIFontRounded',
    'sans-serif-rounded',
    'Arial Rounded MT Bold',
    'sans-serif',
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamilyFallback: _fontFallbacks,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        brightness: Brightness.light,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamilyFallback: _fontFallbacks,
        ),
      ),

      // Primary Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
            fontFamilyFallback: _fontFallbacks,
          ),
        ),
      ),

      // Secondary Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamilyFallback: _fontFallbacks,
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      // Input Decoration Theme (Search Bar, Text Fields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF0F5FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamilyFallback: _fontFallbacks,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      // Bottom Navigation Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.navBackground,
        selectedItemColor: AppColors.navActive,
        unselectedItemColor: AppColors.navInactive,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          fontFamilyFallback: _fontFallbacks,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamilyFallback: _fontFallbacks,
        ),
      ),
    );
  }
}
