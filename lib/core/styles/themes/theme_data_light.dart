
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

////////// Light Theme ///////////
ThemeData lightTheme =  ThemeData(
  cardTheme: CardTheme(
    elevation: 4.0,
    color: Colors.white.withOpacity(0.8),
    surfaceTintColor: Colors.blue,
  ),

  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70, primary: AppColors.defaultColor , primaryContainer: Colors.white),
  primarySwatch: AppColors.defaultColor,
  primaryColor: AppColors.defaultColor,
  dividerTheme: DividerThemeData(
    color: Colors.grey[400],
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme:  const TextTheme(
    titleSmall: TextStyle(
      //fontWeight: FontWeight.bold,
      fontSize: 17.0,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      //fontWeight: FontWeight.normal,
      fontSize: 13.0,
      color: Colors.grey,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18.0,
      color: Colors.black,
      fontFamily: 'Jannah',
    ),
    titleMedium: TextStyle(
      height: 1.3,
      fontSize: 14.0,
      color: Colors.black,
      fontFamily: 'Jannah',
      fontWeight: FontWeight.normal,
    ),
  ),
  inputDecorationTheme:  InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.black87.withOpacity(0.8),
      fontWeight: FontWeight.normal,
      fontSize: 15.0,
    ),
    labelStyle: TextStyle(
      color: Colors.black87.withOpacity(0.8),
      fontWeight: FontWeight.normal,
    ),

    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),

  ),
  appBarTheme:  AppBarTheme(
      titleSpacing: 16.0,
      titleTextStyle: TextStyle(
        fontFamily: "Jannah",
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.defaultColor,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 15.0,
    backgroundColor: Colors.white,
  ),
  fontFamily: 'Jannah',

);