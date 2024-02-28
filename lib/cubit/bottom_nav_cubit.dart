import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/bookmarks_screen.dart';
import 'package:news_app/modules/news_screen.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/modules/settings_screen.dart';

class BottomNavCubit extends Cubit<AppStates> {
  BottomNavCubit() : super(InitState());

  // Cubit getter
  BottomNavCubit get(context) => BlocProvider.of(context);

  //Cubit vars
  int currentNavBarIndex = 0;

  late List<Widget> appScreens = [
    const NewsScreen(),
    const SearchScreen(),
    const BookmarksScreen(),
    const SettingsScreen(),
  ];

  //Cubit methods
  void changeNavBar(index) {
    currentNavBarIndex = index;
    emit(BottomNavBarChangedState());
  }
}
