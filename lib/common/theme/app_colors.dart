import 'package:flutter/material.dart';

/// Centralized Color Palette for the entire application.
class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFFFF7622); // Food delivery vibrant orange
  static const Color primaryLight = Color(0xFFFFE1CE); // Light peach/orange accent
  static const Color primaryDark = Color(0xFFE05E0D);
  static const Color secondary = Color(0xFF181C2E); // Deep navy

  // Background & Surface
  static const Color background = Color(0xFFF9FAFC); // Clean off-white app background
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;

  // Typography
  static const Color textPrimary = Color(0xFF181C2E); // Main title navy/black
  static const Color textSecondary = Color(0xFF646982); // Subtitle grey
  static const Color textMuted = Color(0xFFA0A5BA); // Placeholder/caption light grey

  // Borders & Dividers
  static const Color border = Color(0xFFECEFF5);
  static const Color divider = Color(0xFFF0F2F7);

  // States & Feedback
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color ratingStar = Color(0xFFFFB800);

  // Decorative Elements
  static const Color splashRaysOrange = Color(0xFFFF7622);
  static const Color splashRaysGrey = Color(0xFFE8E8E8);
  static const Color indicatorActive = Color(0xFFFF7622);
  static const Color indicatorInactive = Color(0xFFFFE1CE);

  // Bottom Navigation
  static const Color navActive = Color(0xFFFF7622);
  static const Color navInactive = Color(0xFFA0A5BA);
  static const Color navBackground = Colors.white;
}
