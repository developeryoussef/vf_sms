import 'sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';

const Color seconderyColor = Color.fromARGB(255, 42, 77, 150);
const Color mainColor = Color.fromARGB(255, 62, 102, 183);
const Color oMainColor = Color.fromRGBO(62, 102, 183, .7);
const Color appBarIconColorLT = Colors.white;
const Color mainTextColorLT = Color.fromARGB(255, 40, 40, 40);
const Color iconColorLT = Colors.white;
const Color shadowColorLT = Color.fromARGB(90, 172, 172, 172);
const Color cardColorLT = Color.fromARGB(255, 254, 254, 255);
const Color scaffoldBackgroundColorLT = Color.fromARGB(255, 240, 238, 252);

class LightTheme with SubThemeData {
  ThemeData buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: scaffoldBackgroundColorLT,
        iconTheme: getIconTheme(),
        splashColor: seconderyColor.withOpacity(0.1),
        highlightColor: mainColor.withOpacity(0.05),
        splashFactory: InkRipple.splashFactory,
        textTheme: getTextThemes().apply(
            bodyColor: mainTextColorLT,
            displayColor: mainTextColorLT,
            fontFamily: 'ArbFONTS'),
        primaryColor: mainColor,
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: getElavatedButtonTheme()),
        cardColor: cardColorLT,
        colorScheme: ColorScheme.fromSwatch(
            accentColor: mainColor, primarySwatch: Colors.purple));
  }
}
