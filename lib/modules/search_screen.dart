import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  bool isSearching=false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit().get(context);
          return isSearching
              ? Center(child: CircularProgressIndicator())
              : Container(
                color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultSearchBar(),
                    SizedBox(height: 10),
                    // News List
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                          color:Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Found ${newsCubit.businessNewsList.length} results", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                              SizedBox(height: 15),
                              Expanded(child: newsList(newsCubit.businessNewsList,))
                            ],
                          )),
                    ),
                  ],
                ),
              );
        });
  }
}
