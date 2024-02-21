import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class BookmarksScreen extends StatelessWidget {
  BookmarksScreen({super.key});

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit().get(context);
          return Padding(
            padding: const EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          "https://getwallpapers.com/wallpaper/full/2/7/5/1343576-free-black-and-white-newspaper-wallpaper-2048x1365-hd-for-mobile.jpg"),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment(-0.6,0.9),
                        child: Text(
                          "Your Bookmarked News!",
                          style: TextStyle(color:Colors.white,fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                    child: newsList(
                  newsCubit.categorizedNewsList,
                ))
              ],
            ),
          );
        });
  }
}
