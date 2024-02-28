import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/bookmarks_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {

  late BookmarksCubit bookmarksCubit;
  // var xx;
  @override
  void initState() {
    bookmarksCubit=BookmarksCubit().get(context);
    bookmarksCubit.getDataFromDatabase();
    // print(xx);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarksCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // BookmarksCubit bookmarksCubit=BookmarksCubit().get(context);
          // bookmarksCubit.getDataFromDatabase(bookmarksCubit.database).then((value) => bookmarksCubit.bookmarksList=value);
          return Padding(
            padding: const EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          "https://getwallpapers.com/wallpaper/full/2/7/5/1343576-free-black-and-white-newspaper-wallpaper-2048x1365-hd-for-mobile.jpg"),
                    ),
                    const Positioned.fill(
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
                const SizedBox(height: 15),
                // News List
                Expanded(
                    child: bookmarksCubit.bookmarksList.isEmpty?Center(child: Text(AppLocalizations.of(context)!.noData),):newsList(
                        bookmarksCubit.bookmarksList
                ))
              ],
            ),
          );
        });
  }
}
