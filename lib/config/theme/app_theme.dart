import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_style_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: GoogleFonts.roboto(
        color: AppColors.black,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.blue[50],
        foregroundColor: AppColors.white,
        textStyle: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: AppColors.black[40]?? Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: AppColors.black[40]?? Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: AppColors.black[60]?? Colors.grey, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.red, width: 2.0),
      ),
      labelStyle: GoogleFonts.roboto(color: AppColors.black, fontSize: 16),
      hintStyle: GoogleFonts.roboto(color: AppColors.black[40], fontSize: 14),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    ),


    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBlue,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.blue,
      showUnselectedLabels: true,
      selectedLabelStyle:getMediumStyle(color: AppColors.blue,
        fontSize: FontSize.s12
       ),
      unselectedLabelStyle: getMediumStyle(color: AppColors.blue,
          fontSize: FontSize.s12
      ),
      type: BottomNavigationBarType.fixed
    )
  );
}
