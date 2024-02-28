import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components/constants.dart';
import 'dart:ui';

class NewsCubit extends Cubit<AppStates> {
  NewsCubit() : super(InitState());

  // Cubit getter
  NewsCubit get(context) => BlocProvider.of(context);

  //Cubit vars
  Locale language=CacheHelper.getData(key: "isArabic")??false?Locale('ar'):Locale('en');
  String country=countries[CacheHelper.getData(key: "countryIdx") ?? 0];
  List<String> categoriesList = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  List<dynamic> trendingNewsList=[];
  List<dynamic> categorizedNewsList=[[],[],[],[],[],[],[],];
  List<dynamic> searchNewsList=[];
  int searchResults=0;
  bool isSearching=false;

  //Cubit methods

  void getTrendingNews(){
    emit(TrendingNewsLoadingState());
    DioHelper.getData(
      option: "/top-headlines",
      query: {
        "country":country,
        "apiKey":apiKey,
      },
    ).then((value){
      trendingNewsList=value.data["articles"];
      emit(TrendingNewsSuccessState());
    }).catchError((error){
      print("Error in getting Business News ${error.toString()}");
      emit(TrendingNewsErrorState());
    });
  }

  void getCategoriesNews(selectedIndex){
    emit(CategorizedNewsLoadingState());
    DioHelper.getData(
        option: "/top-headlines",
        query: {
          "country":country,
          "category": categoriesList[selectedIndex],
          "apiKey":apiKey,
        },
    ).then((value){
      print(value.data["articles"][0]["author"]);
      categorizedNewsList.insert(selectedIndex,value.data["articles"]);
      emit(CategorizedNewsSuccessState());
    }).catchError((error){
      print("Error in getting Categorized News ${error.toString()}");
      emit(CategorizedNewsErrorState());
    });
  }

  void searchNews(query){
    emit(TrendingNewsLoadingState());
    DioHelper.getData(
      option: "/everything",
      query: {
        "q":query,
        "apiKey":apiKey,
      },
    ).then((value){
      searchResults=value.data["totalResults"];
      searchNewsList=value.data["articles"];
      emit(TrendingNewsSuccessState());
    }).catchError((error){
      print("Error in getting Business News ${error.toString()}");
      emit(TrendingNewsErrorState());
    });
  }


}

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=96441a138a154921875a803ef7c5cf03
//Your API key is: 5507ce9111b0462fb738f75fd36ab1e7