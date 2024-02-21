import 'package:flutter/material.dart';

lightThemeData() => ThemeData(
      primaryColor: Colors.black,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.black,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.black,
        tabAlignment: TabAlignment.center,
      ),
    );

darkThemeData() => ThemeData(
      scaffoldBackgroundColor: Color(0xFF333739),
      primaryColor: Colors.white,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        color: Color(0xFF333739),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.white),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white30,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
        tabAlignment: TabAlignment.center,
      ),
  iconTheme: IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    headlineLarge:TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  )
    );
