import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CataClothesTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineSmall: GoogleFonts.lato(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: Colors.black
    ),
    titleLarge: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Colors.black
    ),
    titleMedium: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: Colors.black
    ),
    titleSmall: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Colors.black
    ),
    bodyLarge: GoogleFonts.lato(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.black
    ),
    bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.black
    ),
    labelLarge: GoogleFonts.lato(
        fontSize: 9,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: Colors.black
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineSmall: GoogleFonts.lato(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: Colors.white
    ),
    titleLarge: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Colors.white
    ),
    titleMedium: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: Colors.white
    ),
    titleSmall: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Colors.white
    ),
    bodyLarge: GoogleFonts.lato(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.white
    ),
    bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.white
    ),
    labelLarge: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: Colors.white
    ),
  );

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      //colorSchemeSeed: Colors.orange,
      // colorScheme: ColorScheme.fromSwatch().copyWith(
      //   primary: Colors.orange,
      //   brightness: Brightness.light,
      // ),
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      colorScheme: const ColorScheme.light().copyWith(
        primary:Color.fromARGB(255, 116, 167, 163),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(100, 8, 138, 127),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: lightTextTheme.titleMedium,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.black;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.orange;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.orange;
          }
          return null;
        }),
      ),
      chipTheme: ChipThemeData(
        checkmarkColor: Colors.white,
        color: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.black;
          }
          return null;
        }),
      ),
      textTheme: lightTextTheme,
    );
  }
}
