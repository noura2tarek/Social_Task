import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[200]!, primary:defaultColor , primaryContainer: Colors.white),
  primarySwatch: defaultColor,
  dividerTheme: DividerThemeData(
    color: Colors.grey[200],
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    labelStyle: TextStyle(
      color: Colors.white,
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
      bodySmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.white,
      ),
    titleMedium: TextStyle(
      height: 1.3,
      fontSize: 14.0,
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
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
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  fontFamily: 'Jannah',
);

ThemeData lightTheme =  ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[200]!, primary:defaultColor , primaryContainer: Colors.white),
  primarySwatch: defaultColor,
  primaryColor: Colors.indigo,
  dividerTheme: DividerThemeData(
    color: Colors.grey[400],
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme:  TextTheme(

    // bodyMedium: TextStyle(
    //   //fontWeight: FontWeight.normal,
    //   fontSize: 22.0,
    //   color: Colors.black,
    //   fontFamily: 'Jannah',
    // ),
    titleMedium: TextStyle(
      height: 1.3,
      fontSize: 14.0,
      color: Colors.black,
      fontFamily: 'Jannah',
      //fontWeight: FontWeight.normal,
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
    selectedItemColor: defaultColor,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 15.0,
    backgroundColor: Colors.white,
  ),
  fontFamily: 'Jannah',

  //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //useMaterial3: true,
);