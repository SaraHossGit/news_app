import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/layouts/home_layout.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/shared/style/colors.dart';

import 'shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..getBusinessNews(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // /// Localization
        // localizationsDelegates: const [
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('ar', 'AE'),
        // ],
        // // Current Locale
        // locale: Locale('ar', 'AE'),
        home: HomeLayout(),
        theme: ThemeData(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.black,
            ),
            primarySwatch: Colors.teal,
            primaryColor: Colors.black,
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: Colors.black,
            )),
      ),
    );
  }
}
