import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/news_screen.dart';
import 'package:news_app/shared/components/components.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String userName = "Sara Hossam";
  String userImg = "";
  bool isDark = true;

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
                  CircleAvatar(
                    backgroundImage: userImg.isEmpty
                        ? const AssetImage("assets/images/profile.jpg")
                        : AssetImage(userImg),
                  ),
                  // SizedBox(width: 16,),
                ],
              ),
              // Username
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello,",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  userName.isEmpty
                      ? SizedBox()
                      : Text(userName, style: const TextStyle(fontSize: 14))
                ],
              ),
              // Toggle Theme
              actions: [
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      isDark = value;
                    });
                    print(value);
                  },
                  activeColor: Colors.black,
                  // activeThumbImage: AssetImage("assets/images/profile.jpg"),
                  // inactiveThumbImage: AssetImage("assets/images/profile.jpg"),
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
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 10),
                      child: customNavBar(
                          bottomNavItemsList: bottomNavCubit.bottomNavItemsList,
                          bottomNavCubit: bottomNavCubit),
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
