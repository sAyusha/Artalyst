import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';

class AppTheme {
  AppTheme._();

  // light theme
  static getApplicationTheme(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
      ),
      
      fontFamily: "Poppins",
      useMaterial3: true,

      scaffoldBackgroundColor: AppColorConstant.primaryAccentColor,

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColorConstant.appBarColor,
        titleTextStyle: MediaQuery.of(context).size.shortestSide >= 600
            ? TextStyle(
                fontSize: 40,
                fontFamily: "Laila",
                fontWeight: FontWeight.w600,
                color: AppColorConstant.blackTextColor,
                letterSpacing: 1.5,
              )
            : TextStyle(
                fontSize: 28,
                fontFamily: "Laila",
                fontWeight: FontWeight.w600,
                color: AppColorConstant.blackTextColor,
                letterSpacing: 1.5,
              ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColorConstant.buttomNavigationColor,
        selectedItemColor: const Color.fromARGB(255, 250, 196, 196),
        unselectedItemColor: AppColorConstant.whiteTextColor,
        showSelectedLabels: false, // Hide the labels
        showUnselectedLabels: false, // Hide the labels
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColorConstant.neutralColor,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),

      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
              foregroundColor: AppColorConstant.neutralColor)),

      // datePickerTheme: DatePickerThemeData(

      // )

    );
  }
}
