import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

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
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      pageTitle(
                          title: AppLocalizations.of(context)!.hotNews,
                          onTap: () {},
                          context: context),
                      defaultCarousel(newsCubit.trendingNewsList),
                      defaultSeparator(),
                      pageTitle(
                          title:
                              AppLocalizations.of(context)!.exploreByCategory,
                          onTap: () {},
                          context: context),
                      categoriesTabBar(
                          context: context,
                          cubit: newsCubit,
                          tabController: _tabController),
                      const SizedBox(height: 10),
                      categoriesTabView(
                          tabController: _tabController,
                          articlesList: newsCubit.categorizedNewsList,
                          numOfTabs: tabItemsList.length),
                    ],
                  ),
                );
        });
  }
}
