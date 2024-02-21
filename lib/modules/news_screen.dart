import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  List<String> tabItemsList = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabItemsList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit().get(context);
          return newsCubit.trendingNewsList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      pageTitle(title: "Hot News", onTap: () {}),
                      defaultCarousel(newsCubit.trendingNewsList),
                      defaultSeparator(),
                      pageTitle(title: "Explore By Category", onTap: () {}),
                      categoriesTabBar(
                          cubit: newsCubit,
                          tabController: _tabController,
                          tabItemsList: tabItemsList),
                      SizedBox(height: 10),
                      categoriesTabView(
                          tabController: _tabController,
                          articlesList: newsCubit.categorizedNewsList,
                          tabItemsList: tabItemsList),
                    ],
                  ),
                );
        });
  }
}
