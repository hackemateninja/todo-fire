import 'package:flutter/material.dart';

ThemeData buildAppTheme()=> ThemeData(
  primarySwatch: Colors.grey,
  dividerColor: Colors.white,
  fontFamily: 'Merienda',
  scaffoldBackgroundColor: Colors.redAccent,
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0)
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(12.0),
      labelStyle: TextStyle(color: Colors.white, fontSize: 15.0),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 10.0
          ),
          borderRadius: BorderRadius.circular(10.5)
      )
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    buttonColor: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 10.0)
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontFamily: 'Merienda'),
    unselectedLabelColor: Colors.black,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.redAccent, width: 5.0)
    )
  ),
);