import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppText.sansFamily,
      scaffoldBackgroundColor: AppColors.cream,
    );

    final scheme = const ColorScheme.light(
      primary: AppColors.dark,
      onPrimary: Colors.white,
      secondary: AppColors.accent,
      onSecondary: Colors.white,
      surface: AppColors.cream,
      onSurface: AppColors.ink,
      error: Color(0xFFB3261E),
      onError: Colors.white,
      outline: AppColors.line,
    );

    return base.copyWith(
      colorScheme: scheme,
      splashFactory: InkSparkle.splashFactory,
      highlightColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lineSoft,
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        displayLarge: AppText.serif(size: 40, weight: FontWeight.w500),
        displayMedium: AppText.serif(size: 32, weight: FontWeight.w500),
        displaySmall: AppText.serif(size: 26, weight: FontWeight.w500),
        headlineMedium: AppText.serif(size: 22, weight: FontWeight.w500),
        headlineSmall: AppText.serif(size: 19, weight: FontWeight.w500),
        titleLarge: AppText.serif(size: 17, weight: FontWeight.w500),
        titleMedium: AppText.sans(size: 13, weight: FontWeight.w600),
        titleSmall: AppText.sans(size: 12, weight: FontWeight.w500),
        bodyLarge: AppText.sans(size: 13),
        bodyMedium: AppText.sans(size: 12, color: AppColors.mutedDark),
        bodySmall: AppText.sans(size: 11, color: AppColors.muted),
        labelLarge: AppText.sans(size: 11, weight: FontWeight.w600),
        labelMedium: AppText.label(),
        labelSmall: AppText.label(size: 8.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.dark,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: const StadiumBorder(),
          textStyle: AppText.sans(
            size: 12,
            weight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.line),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: const StadiumBorder(),
          textStyle: AppText.sans(size: 12, weight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: AppText.sans(size: 11, weight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        hintStyle: AppText.sans(size: 12, color: AppColors.muted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.ink, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFB3261E)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.cream,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.dark,
        contentTextStyle: AppText.sans(size: 12, color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder(),
      ),
    );
  }
}
