import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/local/cache_helper.dart';

class ThemeCubit extends Cubit<AppStates> {
  ThemeCubit() : super(InitState());

  // Cubit getter
  ThemeCubit get(context) => BlocProvider.of(context);

  //Cubit vars
  int currentNavBarIndex = 0;
  bool isDark = true;

  //Cubit methods
  void changeThemeMode({bool? isDarkFromShared}) {
    if (isDarkFromShared == null) {
      isDark = !isDark;
      CacheHelper.saveData(key: "isDark", value: isDark)
          .then((value) => emit(ThemeModeChangedState()));
    } else {
      // if there is a cached value, get it
      isDark = CacheHelper.getData(key: "isDark");
    }
  }
}
