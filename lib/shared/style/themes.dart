import 'package:flutter/material.dart';
import 'package:news_app/shared/style/colors.dart';

lightThemeData() => ThemeData(
      primaryColor: Colors.black,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.black,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.black,
        tabAlignment: TabAlignment.center,
      ),
    );

darkThemeData() => ThemeData(
      scaffoldBackgroundColor: darkThemeBG,
      primaryColor: Colors.white,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        color: darkThemeBG,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(color: Colors.white),
        toolbarTextStyle: const TextStyle(color: Colors.white),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white30,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
        tabAlignment: TabAlignment.center,
      ),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    headlineLarge:TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  )
    );
