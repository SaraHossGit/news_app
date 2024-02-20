import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/news_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components/constants.dart';

class BottomNavCubit extends Cubit<AppStates> {
  BottomNavCubit() : super(InitState());

  // Cubit getter
  BottomNavCubit get(context) => BlocProvider.of(context);

  //Cubit vars
  int currentNavBarIndex=0;
  late List<GButton> bottomNavItemsList= [
    const GButton(
      icon: Icons.home_outlined,
      text: "Home",
    ),
    const GButton(
      icon: Icons.search,
      text: "Search",
    ),
    const GButton(
      icon: Icons.bookmark_border_outlined,
      text: "Bookmarks",
    ),
    const GButton(
      icon: Icons.settings_outlined,
      text: "Settings",
    ),
  ];

  late List<Widget> appScreens=[NewsScreen(),NewsScreen(),NewsScreen(),NewsScreen(),];

  //Cubit methods
  void changeNavBar(index){
    currentNavBarIndex=index;
    emit(BottomNavBarChangedState());
  }


}
