import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit().get(context);
          return newsCubit.businessNewList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => defaultNewsTile(
                            articlesList: newsCubit.businessNewList,
                            index: index,
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: 10),
                );
        });
  }
}
