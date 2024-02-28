import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/theme_cubit.dart';
import 'package:news_app/modules/news_webview.dart';

/// General
Widget defaultButton(
        {required VoidCallback changeSettingsFunc,
        String buttonText = "Submit"}) =>
    Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
          onPressed: changeSettingsFunc,
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ));

Widget defaultSeparator() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

Widget defaultSearchBar({required void Function(String)? onChanged}) =>
    TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        label: const Text("Search"),
        contentPadding: const EdgeInsets.all(20),
        hintText: "Search News...",
        floatingLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        suffixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );

Widget customNavBar({
  required List<GButton> bottomNavItemsList,
  required var bottomNavCubit,
  required BuildContext context,
}) =>
    GNav(
      hoverColor: Colors.grey.withOpacity(0.7),
      // tab button hover color
      haptic: true,
      // haptic feedback
      tabBorderRadius: 15,
      tabActiveBorder: Border.all(color: Colors.black, width: 1),
      // tab button border
      curve: Curves.easeOutExpo,
      // tab animation curves
      duration: const Duration(milliseconds: 500),
      // tab animation duration
      gap: 8,
      // the tab button gap between icon and text
      color:
          ThemeCubit().get(context).isDark ? Colors.white30 : Colors.grey[800],
      // unselected icon color
      activeColor: Colors.white,
      // selected icon and text color
      iconSize: 24,
      // tab button icon size
      tabBackgroundColor: Colors.black,
      // selected tab background color
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // navigation bar padding
      tabs: bottomNavItemsList,
      onTabChange: (index) {
        bottomNavCubit.changeNavBar(index);
      },
    );

Widget pageTitle({
  required BuildContext context,
  required String title,
  required VoidCallback onTap,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              AppLocalizations.of(context)!.seeAll,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );

/// News List and List tiles
Widget defaultNewsTile({
  required BuildContext context,
  required List<dynamic> articlesList,
  required int idx,
}) =>
    InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewsWebview(
                newsLink: articlesList[idx]["url"],
                newsDate: articlesList[idx]["publishedAt"],
                newsImage: articlesList[idx]["urlToImage"] ??
                    "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png",
                newsSource: articlesList[idx]["author"] ?? "Unknown",
                newsTitle: articlesList[idx]["title"],
              ))),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                articlesList[idx]["urlToImage"] ??
                    "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png",
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${articlesList[idx]["title"]}",
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          articlesList[idx]["author"] ?? "Unknown",
                          style: TextStyle(color: Colors.grey[500]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        articlesList[idx]["publishedAt"]
                            .toString()
                            .substring(0, 10),
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget newsList(articlesList) {
  if (!articlesList.isEmpty) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => defaultNewsTile(
            articlesList: articlesList, idx: index, context: context),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: articlesList.length);
  }
  return const Center(
    child: CircularProgressIndicator(),
  );
}

/// Carousel
Widget defaultCarousel(newsList) => CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: carouselItemBuilder(newsList),
    );

List<Widget> carouselItemBuilder(newsList) {
  List<Widget> itemsList = [];
  for (int i = 0; i < newsList.length; i++) {
    // Don't add news items with no images
    if (newsList[i]["urlToImage"] != null) {
      itemsList.add(carouselItem(newsList[i]));
    }
  }
  return itemsList;
}

Widget carouselItem(newsItem) => Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              Image.network(
                newsItem["urlToImage"],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Background to Title
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),

                          /// Offset from the container
                          blurRadius: 10,

                          /// Blur radius
                          spreadRadius: 5,

                          /// Spread radius
                        )
                      ],
                    )),
              ),
              // Source
              Align(
                  alignment: const Alignment(-0.8, 0.3),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      newsItem["author"] ?? "Unknown",
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              // Title
              Align(
                  alignment: const Alignment(-0.8, 0.8),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      newsItem["title"],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ],
          ),
        );
      },
    );

/// TabBar and TabView
Widget categoriesTabBar({
  required TabController? tabController,
  required NewsCubit cubit,
  required BuildContext context,
}) =>
    SizedBox(
        height: 40,
        child: TabBar(
          onTap: (int selectedIndex) {
            if (cubit.categorizedNewsList[selectedIndex].isEmpty) {
              cubit.getCategoriesNews(selectedIndex);
            }
          },
          isScrollable: true,
          controller: tabController,
          tabs: [
            Tab(
              text: AppLocalizations.of(context)!.business,
            ),
            Tab(
              text: AppLocalizations.of(context)!.entertainment,
            ),
            Tab(
              text: AppLocalizations.of(context)!.general,
            ),
            Tab(
              text: AppLocalizations.of(context)!.health,
            ),
            Tab(
              text: AppLocalizations.of(context)!.science,
            ),
            Tab(
              text: AppLocalizations.of(context)!.sports,
            ),
            Tab(
              text: AppLocalizations.of(context)!.technology,
            ),
          ],
        ));

Widget categoriesTabView({
  required TabController? tabController,
  required List<dynamic> articlesList,
  required int numOfTabs,
}) =>
    Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children:
            buildTabPages(articlesList: articlesList, numOfTabs: numOfTabs),
      ),
    );

List<Widget> buildTabPages(
    {required List<dynamic> articlesList, required int numOfTabs}) {
  List<Widget> tabScreens = [];
  for (int i = 0; i < numOfTabs; i++) {
    tabScreens.add(newsList(articlesList[i]));
  }
  return tabScreens;
}
