import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFF10B981)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      useMaterial3: false,
      secondaryHeaderColor: const Color(0xFF3B82F6),
      disabledColor: const Color(0xFF9CA3AF),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      hintColor: const Color(0xFF6B7280),
      cardColor: Colors.white,
      iconTheme: const IconThemeData(color: Color(0xFF374151)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF111827)),
        bodyMedium: TextStyle(color: Color(0xFF374151)),
        titleLarge: TextStyle(
          color: Color(0xFF10B981),
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF374151)),
        titleTextStyle: TextStyle(
          color: Color(0xFF111827),
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        elevation: 1,
        shadowColor: Color(0x1A000000),
      ),
      colorScheme: ColorScheme.light(
        primary: color,
        secondary: const Color(0xFF3B82F6),
        background: const Color(0xFFF8FAFC),
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: const Color(0xFF111827),
        onSurface: const Color(0xFF111827),
      ),
    );
