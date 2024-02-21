import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';

class ThemeCubit extends Cubit<AppStates> {
  ThemeCubit() : super(InitState());

  // Cubit getter
  ThemeCubit get(context) => BlocProvider.of(context);

  //Cubit vars
  int currentNavBarIndex=0;
  bool isDark=false;

  //Cubit methods
  void changeThemeMode(){
    isDark=!isDark;
    emit(ThemeModeChangedState());
  }


}
