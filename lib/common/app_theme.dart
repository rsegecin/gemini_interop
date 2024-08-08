// ignore_for_file: constant_identifier_names

import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const int MOBILE_NAVIGATION_MAX_WIDTH = 850;
  static const double MAX_BACKBONE_WIDTH = 650;

  static const Color primaryColor = Colors.purple;

  static ColorScheme flexLightColorScheme = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: primaryColor,
    contrastLevel: .75,
    tones: FlexTones.highContrast(Brightness.light),
  );

  static ColorScheme flexDarkColorScheme = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: primaryColor,
    contrastLevel: .75,
    tones: FlexTones.highContrast(Brightness.dark),
  );

  static final flexLightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: flexLightColorScheme,
    visualDensity: VisualDensity.standard,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    typography: Typography.material2021(
      platform: defaultTargetPlatform,
    ),
  );

  static final flexDarkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: flexDarkColorScheme,
    visualDensity: VisualDensity.standard,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    typography: Typography.material2021(
      platform: defaultTargetPlatform,
    ),
  );

  static final partialInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(color: primaryColor),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(color: primaryColor),
    ),
  );

  static final lightTheme = flexLightTheme.copyWith(
    inputDecorationTheme:
        flexLightTheme.inputDecorationTheme.merge(partialInputDecorationTheme),
  );

  static final darkTheme = flexDarkTheme.copyWith(
    inputDecorationTheme: flexDarkTheme.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: const Color(0xFF323232),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: primaryColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        borderSide: BorderSide(color: primaryColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        borderSide: BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
    ),
  );
}
