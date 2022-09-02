import 'package:flutter/material.dart';
import '../../tools/extension/int_extension.dart';

class ThemeConfig {
  static final double bodyFontSize = 14.px;
  static final double smallFontSize = 16.px;
  static final double mediumFontSize = 18.px;
  static final double largeFontSize = 22.px;

  //默认主题
  static const normalTextColor = Colors.black54;
  static final ThemeData normalTheme = ThemeData(
    primarySwatch: Colors.pink,
    splashColor: Colors.transparent,
    canvasColor: Colors.white,
    textTheme: normalTextTheme,
    textButtonTheme:buttonTheme,
    elevatedButtonTheme: elevatedButtonThemeData
  );

  static final TextTheme normalTextTheme = TextTheme(
    bodyText1: TextStyle(fontSize: bodyFontSize,color: normalTextColor),
    bodyText2: TextStyle(fontSize: smallFontSize,color: normalTextColor,fontWeight: FontWeight.bold),

    headline1: TextStyle(fontSize: largeFontSize,color: normalTextColor,fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: largeFontSize,color: normalTextColor),
    headline3: TextStyle(fontSize: mediumFontSize,color: normalTextColor),
    headline4: TextStyle(fontSize: smallFontSize,color: normalTextColor),
  );

  //暗黑主题
  static const Color darkTextColor = Colors.white12;
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    splashColor: Colors.transparent,
    canvasColor: const Color.fromARGB(1, 255, 254, 222),
    textTheme:  darkTextTheme,
  );
  static final TextTheme darkTextTheme = TextTheme(
    bodyText1: TextStyle(fontSize: bodyFontSize,color: darkTextColor),
    bodyText2: TextStyle(fontSize: mediumFontSize,color: darkTextColor,fontWeight: FontWeight.bold),
    headline1: TextStyle(fontSize: largeFontSize,color: normalTextColor,fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: largeFontSize,color: normalTextColor),
    headline3: TextStyle(fontSize: mediumFontSize,color: normalTextColor),
    headline4: TextStyle(fontSize: smallFontSize,color: normalTextColor),
  );


  static TextButtonThemeData buttonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states){
        return states.contains(MaterialState.pressed) ? Colors.green : Colors.transparent;
      }),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 15.px,fontWeight: FontWeight.w600,color: Colors.green))
    )
  );

  static ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states){
        return states.contains(MaterialState.pressed) ? Colors.orange : Colors.pink;
      }),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 15.px,fontWeight: FontWeight.w600,color: Colors.green))
    )
  );
}
