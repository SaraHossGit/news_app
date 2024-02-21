abstract class AppStates {}
class InitState extends AppStates{}

class ThemeModeChangedState extends AppStates{}

class BottomNavBarChangedState extends AppStates{}

class TrendingNewsLoadingState extends AppStates{}
class TrendingNewsSuccessState extends AppStates{}
class TrendingNewsErrorState extends AppStates{}

class CategorizedNewsLoadingState extends AppStates{}
class CategorizedNewsSuccessState extends AppStates{}
class CategorizedNewsErrorState extends AppStates{}