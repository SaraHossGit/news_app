import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit().get(context);
          return Container(
                color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultSearchBar(),
                    const SizedBox(height: 10),
                    // News List
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                          color:Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Found ${newsCubit.searchNewsList.length} results", style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                              const SizedBox(height: 15),
                              Expanded(child: newsList(newsCubit.searchNewsList,))
                            ],
                          )),
                    ),
                  ],
                ),
              );
        });
  }
}
