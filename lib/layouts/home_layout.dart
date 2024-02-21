import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/cubit/theme_cubit.dart';
import 'package:news_app/shared/components/components.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String userName = "Sara Hossam";
  String userImg = "";

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
                  Text(
                    "Hello,",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ThemeCubit().get(context).isDark?Colors.white30:Colors.grey[700]),
                  ),
                  userName.isEmpty
                      ? SizedBox()
                      : Text(userName,
                          style: Theme.of(context).textTheme.labelLarge)
                ],
              ),
              // Toggle Theme
              actions: [
                Text(
                  "Dark Mode",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Switch(
                  value: ThemeCubit().get(context).isDark,
                  onChanged: (value) {
                    setState(() {
                      ThemeCubit().get(context).changeThemeMode();
                    });
                    print(value);
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
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 10),
                      child: customNavBar(
                          bottomNavItemsList: bottomNavCubit.bottomNavItemsList,
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
