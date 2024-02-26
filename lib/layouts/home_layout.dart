import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/cubit/theme_cubit.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String userName = CacheHelper.getData(key: "userName");
  String userImgPath = CacheHelper.getData(key: "userImg");
  late File userImg = File(userImgPath);
  late List<GButton> bottomNavItemsList = [
    GButton(
      icon: Icons.home_outlined,
      text: AppLocalizations.of(context)!.home,
    ),
    GButton(
      icon: Icons.search,
      text: AppLocalizations.of(context)!.search,
    ),
    GButton(
      icon: Icons.bookmark_border_outlined,
      text: AppLocalizations.of(context)!.bookmarks,
    ),
    GButton(
      icon: Icons.settings_outlined,
      text: AppLocalizations.of(context)!.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          BottomNavCubit bottomNavCubit = BottomNavCubit().get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              // Profile Pic
              leading: Row(
                children: [
                  const SizedBox(width: 16),
                  userImg != null
                      ? CircleAvatar(backgroundImage: FileImage(userImg))
                      : const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile.jpg"),
                        ),
                ],
              ),
              // Username
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.hello,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ThemeCubit().get(context).isDark
                            ? Colors.white30
                            : Colors.grey[700]),
                  ),
                  userName.isEmpty
                      ? const SizedBox()
                      : Text(userName,
                          style: Theme.of(context).textTheme.labelLarge)
                ],
              ),
              // Toggle Theme
              actions: [
                Text(
                  AppLocalizations.of(context)!.darkMode,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Switch(
                  value: ThemeCubit().get(context).isDark,
                  onChanged: (value) {
                    setState(() {
                      ThemeCubit().get(context).changeThemeMode();
                    });
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.black,
                )
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Current Screen
                  Expanded(
                      child: bottomNavCubit
                          .appScreens[bottomNavCubit.currentNavBarIndex]),

                  // Bottom Nav Bar
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: customNavBar(
                          bottomNavItemsList: bottomNavItemsList,
                          bottomNavCubit: bottomNavCubit,
                          context: context),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// Your API key is: 96441a138a154921875a803ef7c5cf03
