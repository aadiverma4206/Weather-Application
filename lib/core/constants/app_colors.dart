import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xff6C63FF);
  static const Color secondary = Color(0xff00C9A7);
  static const Color accent = Color(0xffFFB86C);

  static const Color background = Color(0xff0F172A);
  static const Color surface = Color(0xff1E293B);
  static const Color card = Color(0xff1E1E2C);

  static const Color textPrimary = Color(0xffffffff);
  static const Color textSecondary = Color(0xffA1A1AA);
  static const Color textMuted = Color(0xff6B7280);

  static const Color success = Color(0xff22C55E);
  static const Color error = Color(0xffEF4444);
  static const Color warning = Color(0xffF59E0B);

  static const Color border = Color(0xff2D3748);
  static const Color divider = Color(0xff374151);

  static const Gradient primaryGradient = LinearGradient(
    colors: [
      Color(0xff6C63FF),
      Color(0xff5A54E6),
      Color(0xff483FD1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient blueGradient = LinearGradient(
    colors: [
      Color(0xff2193b0),
      Color(0xff6dd5ed),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient sunsetGradient = LinearGradient(
    colors: [
      Color(0xffff7e5f),
      Color(0xfffeb47b),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkGradient = LinearGradient(
    colors: [
      Color(0xff0f2027),
      Color(0xff203a43),
      Color(0xff2c5364),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Color glass = Colors.white.withOpacity(0.08);
  static Color glassBorder = Colors.white.withOpacity(0.12);
  static Color shadow = Colors.black.withOpacity(0.4);

  static const double radiusSmall = 8;
  static const double radiusMedium = 16;
  static const double radiusLarge = 24;
  static const double radiusXL = 32;

  static const Duration animationFast = Duration(milliseconds: 300);
  static const Duration animationMedium = Duration(milliseconds: 600);
  static const Duration animationSlow = Duration(milliseconds: 900);
}