import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/cubit/theme_cubit.dart';
import 'package:news_app/layouts/home_layout.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/shared/style/colors.dart';
import 'package:news_app/shared/style/themes.dart';

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
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..getCategoriesNews(0)..getTrendingNews(),
        ),
      ],
      child: BlocConsumer<ThemeCubit, AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
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

            // Theme Data
            theme: lightThemeData(),
            darkTheme: darkThemeData(),
            themeMode: ThemeCubit().get(context).isDark? ThemeMode.dark:ThemeMode.light,

            // Home Layout
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
