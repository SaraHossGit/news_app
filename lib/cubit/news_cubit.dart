import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components/constants.dart';

class NewsCubit extends Cubit<AppStates> {
  NewsCubit() : super(InitState());

  // Cubit getter
  NewsCubit get(context) => BlocProvider.of(context);

  //Cubit vars
  List<dynamic> trendingNewsList=[];
  List<dynamic> businessNewsList=[];

  //Cubit methods

  void getTrendingNews(){
    emit(TrendingNewsLoadingState());
    DioHelper.getData(
      option: "/top-headlines",
      query: {
        "country":"us",
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

  void getBusinessNews(){
    emit(BusinessNewsLoadingState());
    DioHelper.getData(
        option: "/top-headlines",
        query: {
          "country":"eg",
          "category": "business",
          "apiKey":apiKey,
        },
    ).then((value){
      print(value.data["articles"][0]["author"]);
      businessNewsList=value.data["articles"];
      emit(BusinessNewsSuccessState());
    }).catchError((error){
      print("Error in getting Business News ${error.toString()}");
      emit(BusinessNewsErrorState());
    });
  }


}

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=96441a138a154921875a803ef7c5cf03