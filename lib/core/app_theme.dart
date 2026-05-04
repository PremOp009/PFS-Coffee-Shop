import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark mode coffee palette
  static const Color primaryCoffee = Color(0xFFC67C4E); // Warm brown
  static const Color darkBackground = Color(0xFF131313); // Deep charcoal
  static const Color surfaceColor = Color(0xFF1C1C1C); // Slightly lighter charcoal
  static const Color surfaceLight = Color(0xFF2A2A2A); // Card background
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA2A2A2);
  static const Color accentCream = Color(0xFFFFF0D1); // Cream/Beige highlight
  static const Color starYellow = Color(0xFFD4A056);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryCoffee,
      canvasColor: surfaceColor,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(color: textPrimary, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.inter(color: textPrimary, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.inter(color: textPrimary),
        bodyMedium: GoogleFonts.inter(color: textSecondary),
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryCoffee,
        secondary: accentCream,
        surface: surfaceColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
