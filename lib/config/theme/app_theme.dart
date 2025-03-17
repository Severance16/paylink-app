import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorSeed = Color(0xff31363F);
const scaffoldBackgroundColor = Color(0xFFEEEEEE);

class AppTheme {
  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: colorSeed,
    scaffoldBackgroundColor: scaffoldBackgroundColor,

    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates().copyWith(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.montserratAlternates().copyWith(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.montserratAlternates().copyWith(fontSize: 20),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.montserratAlternates().copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
