import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/bottom_nav_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/news_section.dart';
import 'package:news_app/shared/components/components.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  List<String> tabItemsList=["Sports", "Business"];
  List<dynamic> tabScreensList=[];

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
          tabScreensList=[newsCubit.businessNewList,newsCubit.businessNewList];
          return newsCubit.businessNewList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _pageTitle(title: "Hot News"),
                      _hotNewsCarousel(),
                      defaultSeparator(),
                      _pageTitle(title: "Only For You"),
                      _categoriesTabBar(),
                      _categoriesTabView(),
                    ],
                  ),
                );
        });
  }

  Widget _pageTitle({required String title}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "See all",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      );

  Widget _hotNewsCarousel() => CarouselSlider(
        options: CarouselOptions(height: 200.0),
        items: [1, 2, 3].map((i) {
          return carouselItem();
        }).toList(),
      );

  Widget _categoriesTabBar() => TabBar(
      tabAlignment: TabAlignment.center,
      isScrollable: true,
      controller: _tabController,
      tabs: _buildTabItems());

  Widget _categoriesTabView() => Expanded(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _buildTabPages(),
        ),
      );

  List<Widget> _buildTabItems() {
    List<Widget> tabItems = [];
    for (int i = 0; i < tabItemsList.length; i++) {
      tabItems.add(
        Tab(
          text: tabItemsList[i],
        ),
      );
    }
    return tabItems;
  }

  List<Widget> _buildTabPages() {
    List<Widget> tabScreens = [];
    for (int i = 0; i < tabScreensList.length; i++) {
      tabScreens.add(NewsSection(articleList: tabScreensList[0]));
    }
    return tabScreens;
  }
}
