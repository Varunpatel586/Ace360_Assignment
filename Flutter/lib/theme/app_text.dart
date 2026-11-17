import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Two-family type system: Playfair Display for editorial headings and
/// Inter for interface copy — matching the Figma artboards.
class AppText {
  const AppText._();

  static const String serifFamily = 'Playfair Display';
  static const String sansFamily = 'Inter';

  static TextStyle serif({
    double size = 18,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.ink,
    double height = 1.24,
    double spacing = 0,
    FontStyle style = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: serifFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing,
      fontStyle: style,
      decoration: decoration,
    );
  }

  static TextStyle sans({
    double size = 12.5,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.ink,
    double height = 1.35,
    double spacing = 0,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: sansFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing,
      decoration: decoration,
    );
  }

  /// Small caps-style eyebrow used across every section header.
  static TextStyle label({
    double size = 9,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.mutedDark,
    double spacing = 1.3,
  }) {
    return TextStyle(
      fontFamily: sansFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: spacing,
      height: 1.3,
    );
  }
}
