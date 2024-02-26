import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/cubit/theme_cubit.dart';
import 'package:news_app/layouts/home_layout.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/style/themes.dart';

import 'shared/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(key: "isDark");
  DioHelper.init();
  runApp(MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit()..changeThemeMode(isDarkFromShared: isDark),
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
