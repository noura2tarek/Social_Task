
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../colors.dart';

///////// Dark theme ///////////
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[200]!, primary: AppColors.defaultColor , primaryContainer: Colors.white),
  primarySwatch: AppColors.defaultColor,

  cardTheme: CardTheme(
    color: Colors.grey[700],////////
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey[350],
  ),
  inputDecorationTheme:  InputDecorationTheme(

    hintStyle: TextStyle(
      color: Colors.grey[300],
      fontWeight: FontWeight.normal,
      fontSize: 15.0,
    ),
    labelStyle: TextStyle(
      color: Colors.grey[300],
    ),
    prefixIconColor: Colors.white,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),

  ),
  scaffoldBackgroundColor: HexColor('333739'),

  textTheme:  TextTheme(
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18.0,
      color: Colors.white,
      fontFamily: 'Jannah',
    ),
    titleSmall: TextStyle(
      //fontWeight: FontWeight.w800,
      fontSize: 17.0,
      color: Colors.grey[350],
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 13.0,
      color: Colors.grey,
    ),
    titleMedium: TextStyle(
      // height: 1.3,
      fontSize: 14.0,
      color: Colors.white,
      fontFamily: 'Jannah',
    ),
  ),
  appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
       // fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 8.0,
    selectedItemColor: AppColors.defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  fontFamily: 'Jannah',
);