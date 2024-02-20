import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

/// General
Widget defaultSeparator() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

Widget defaultSearchBar()=>TextFormField(
  decoration: InputDecoration(
    label: Text("Search"),
    contentPadding: EdgeInsets.all(20),
    hintText: "Search News...",
    floatingLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    suffixIcon: Icon(Icons.search),
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
      duration: Duration(milliseconds: 500),
      // tab animation duration
      gap: 8,
      // the tab button gap between icon and text
      color: Colors.grey[800],
      // unselected icon color
      activeColor: Colors.white,
      // selected icon and text color
      iconSize: 24,
      // tab button icon size
      tabBackgroundColor: Colors.black,
      // selected tab background color
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // navigation bar padding
      tabs: bottomNavItemsList,
      onTabChange: (index) {
        bottomNavCubit.changeNavBar(index);
        print(index);
      },
    );

Widget pageTitle({required String title}) => Padding(
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

/// News List and List tiles
Widget defaultNewsTile({
  required List<dynamic> articlesList,
  required int index,
}) =>
    Container(
      padding: EdgeInsets.all(10),
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
              // "${articlesList[index]["urlToImage"]}",
              "https://cdn.dribbble.com/users/1726280/screenshots/15941964/media/8eec78bc3bd95b2bd1fe260b36ab5188.jpg",
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${articlesList[index]["title"]}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${articlesList[index]["author"]}",
                          style: TextStyle(color: Colors.grey[500]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "${articlesList[index]["publishedAt"].toString().substring(0, 10)}",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget newsList(articlesList) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => defaultNewsTile(
          articlesList: articlesList,
          index: index,
        ),
    separatorBuilder: (context, index) => SizedBox(height: 10),
    itemCount: 10);

/// Carousel
Widget carouselItem() => Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              Image.network(
                "https://img.apmcdn.org/a91999e158c12fbfc169361abc9e24c8f0373785/widescreen/5d1f8d-20240218-people-around-a-vigil-outside-a-city-hall-2000.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Source and date
              Align(
                  alignment: Alignment(-0.9, 0.3),
                  child: Text(
                    "MPR News Staff",
                    style: TextStyle(color: Colors.white),
                  )),
              // Title
              Align(
                  alignment: Alignment(-0.8, 0.8),
                  child: Container(
                    width: 200,
                    child: Text(
                      "Hundreds gather for vigil after 2 police officers, paramedic killed in Burnsville - MPR News",
                      style: TextStyle(
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

Widget defaultCarousel() => CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: [1, 2, 3].map((i) {
        return carouselItem();
      }).toList(),
    );

/// TabBar and TabView
Widget categoriesTabBar({
  required TabController? tabController,
  required List<dynamic> tabItemsList,
}) =>
    Container(
      height: 40,
      child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.black,
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          controller: tabController,
          tabs: buildTabItems(tabItemsList)),
    );

Widget categoriesTabView({
  required TabController? tabController,
  required List<dynamic> tabScreensList,
}) =>
    Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: buildTabPages(tabScreensList),
      ),
    );

List<Widget> buildTabItems(tabItemsList) {
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

List<Widget> buildTabPages(tabScreensList) {
  List<Widget> tabScreens = [];
  for (int i = 0; i < tabScreensList.length; i++) {
    tabScreens.add(newsList(tabScreensList[0]));
  }
  return tabScreens;
}
