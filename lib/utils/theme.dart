import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './constant.dart';

ThemeData getTheme(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.black,
    primaryColorDark: AppColors.black,
    primaryColorBrightness: Brightness.dark,
    accentColor: AppColors.primary,
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: GoogleFonts.rubikTextTheme(
      textTheme,
    ).copyWith(
      headline1: GoogleFonts.rubik(
          color: AppColors.textSecondary, textStyle: textTheme.headline1),
      headline2: GoogleFonts.rubik(
          color: AppColors.textSecondary, textStyle: textTheme.headline2),
      headline3: GoogleFonts.rubik(
          color: AppColors.textSecondary, textStyle: textTheme.headline3),
      headline4: GoogleFonts.rubik(
          color: AppColors.textSecondary, textStyle: textTheme.headline4),
      headline5: GoogleFonts.rubik(
          color: AppColors.textSecondary, textStyle: textTheme.headline5),
      headline6: GoogleFonts.rubik(
          color: AppColors.primary, textStyle: textTheme.headline6),
      subtitle1: GoogleFonts.rubik(
          color: Colors.black, textStyle: textTheme.subtitle1),
      subtitle2: GoogleFonts.rubik(
          color: AppColors.textSecondary, textStyle: textTheme.subtitle2),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15.0),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 0.4))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 0.4))),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 0.4))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 0.4))),
      fillColor: Color.fromRGBO(220, 220, 220, 0.4),
      filled: true,
      hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
    ),
    buttonTheme: ButtonThemeData(
        disabledColor: AppColors.textSecondary,
        buttonColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.fromLTRB(24, 15, 24, 15),
        focusColor: AppColors.primary,
        highlightColor: AppColors.primary,
        hoverColor: AppColors.primary,
        splashColor: Colors.white,
        textTheme: ButtonTextTheme.normal),
  );
}
