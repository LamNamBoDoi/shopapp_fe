import 'package:flutter/material.dart';

ThemeData dark({Color color = const Color(0xFF6366F1)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      useMaterial3: false,
      secondaryHeaderColor: const Color(0xFF8B5CF6),
      disabledColor: const Color(0xFF6B7280),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      hintColor: const Color(0xFF9CA3AF),
      cardColor: const Color(0xFF1E293B),
      iconTheme: const IconThemeData(color: Color(0xFFE2E8F0)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFF1F5F9)),
        bodyMedium: TextStyle(color: Color(0xFFCBD5E1)),
        titleLarge: TextStyle(
          color: Color(0xFF6366F1),
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E293B),
        iconTheme: IconThemeData(color: Color(0xFFE2E8F0)),
        titleTextStyle: TextStyle(
          color: Color(0xFFF1F5F9),
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        elevation: 0,
      ),
      colorScheme: ColorScheme.dark(
        primary: color,
        secondary: const Color(0xFF8B5CF6),
        background: const Color(0xFF0F172A),
        surface: const Color(0xFF1E293B),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: const Color(0xFFF1F5F9),
        onSurface: const Color(0xFFF1F5F9),
      ),
    );
