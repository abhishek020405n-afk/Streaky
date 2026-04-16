import 'package:flutter/material.dart';

/// Modern Dark Theme for Streaky
class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6366F1); // Indigo
  static const Color primaryLightColor = Color(0xFF818CF8);
  static const Color accentColor = Color(0xFF8B5CF6); // Purple
  static const Color successColor = Color(0xFF10B981); // Emerald
  static const Color warningColor = Color(0xFFF59E0B); // Amber
  static const Color errorColor = Color(0xFFEF4444); // Red

  // Dark Theme Colors
  static const Color darkBg = Color(0xFF0F172A); // Very dark blue-gray
  static const Color darkCard = Color(0xFF1E293B); // Darker slate
  static const Color darkCardAlt = Color(0xFF334155); // Medium slate
  static const Color darkText = Color(0xFFF1F5F9); // Light gray
  static const Color darkTextSecondary = Color(0xFF9CA3AF); // Slate gray
  static const Color darkBorder = Color(0xFF475569);

  // Light Theme Colors
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Gradient Colors
  static const List<Color> primaryGradient = [primaryColor, accentColor];
  static const List<Color> successGradient = [successColor, Color(0xFF059669)];

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    primaryColor: primaryColor,
    canvasColor: darkBg,

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: darkText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: darkText),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: darkBorder, width: 0.5),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCard,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      hintStyle: const TextStyle(color: darkTextSecondary),
      labelStyle: const TextStyle(color: primaryColor),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),

    // Text Themes
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: darkText,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: darkText,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: darkText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: darkText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: darkText,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: darkText,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: darkText,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: darkTextSecondary,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: darkTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: darkCard,
      disabledColor: darkCardAlt,
      selectedColor: primaryColor,
      secondarySelectedColor: accentColor,
      labelStyle: const TextStyle(color: darkText),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: darkBorder,
      thickness: 0.5,
      space: 1,
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: darkTextSecondary,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
  );

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBg,
    primaryColor: primaryColor,
    canvasColor: lightBg,

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: lightText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: lightText),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: lightBorder, width: 0.5),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightBg,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      hintStyle: const TextStyle(color: lightTextSecondary),
      labelStyle: const TextStyle(color: primaryColor),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),

    // Text Themes
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: lightText,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: lightText,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: lightText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: lightText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: lightText,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: lightText,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: lightText,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: lightTextSecondary,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: lightTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: lightBg,
      disabledColor: Color(0xFFE2E8F0),
      selectedColor: primaryColor,
      secondarySelectedColor: accentColor,
      labelStyle: const TextStyle(color: lightText),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: lightBorder,
      thickness: 0.5,
      space: 1,
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: lightTextSecondary,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}
