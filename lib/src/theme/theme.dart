import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.robotoTextTheme().apply(
    fontFamilyFallback: [
       GoogleFonts.anekMalayalam().fontFamily ?? '',
            GoogleFonts.tiroDevanagariHindi().fontFamily ?? '',
    ]
    //   headlineLarge: TextStyle(
    //     // fontSize: 40,
    //     fontWeight: FontWeight.bold,
    //     color: colorScheme.onPrimaryContainer,
    //   ),
    //   headlineMedium: TextStyle(
    //     // fontSize: 32,
    //     fontWeight: FontWeight.w600,
    //     // color: colorScheme.onSurface,
    //   ),
    //   bodyLarge: TextStyle(fontSize: 16, color: colorScheme.onPrimaryContainer),
    //   titleLarge: TextStyle(
    //     // fontSize: 24,
    //     fontWeight: FontWeight.w600,
    //     color: colorScheme.onPrimaryContainer,
    //   ),
    //   titleSmall: TextStyle(color: colorScheme.onPrimaryContainer),
    //   bodyMedium: TextStyle(color: colorScheme.onPrimaryContainer),
    // ),
  ),
  dividerTheme: DividerThemeData(color: colorScheme.primary, thickness: 4),
);
final ThemeData darkTheme = ThemeData.dark();

final ColorScheme colorScheme = ColorScheme.light(
  primary: Color(0Xff3198FF),
  secondary: Color(0xff15DB36),
  surface: Color(0xff384963),
  surfaceDim: Color(0Xff1B2A41),
  surfaceBright: Color(0xff7194C9),
  primaryContainer: Color(0xffD9D9D9),
  outline: Colors.blueGrey.shade300,
  onSurface: Color(0xffD9D9D9),
  onPrimaryContainer: Color(0Xff1B2A41),
);
