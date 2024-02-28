import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:news_app/cubit/bookmarks_cubit.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/cubit/theme_cubit.dart';
import 'package:news_app/layouts/home_layout.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/style/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'shared/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()..changeThemeMode(isDarkFromShared: true),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..getCategoriesNews(0)..getTrendingNews(),
        ),
        BlocProvider(
          create: (context) => BookmarksCubit()..createBookmarksDatabase(),
        ),
      ],
      child: BlocConsumer<ThemeCubit, AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            /// Localization
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            // Current Locale
            locale: NewsCubit().get(context).language,

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
