abstract class AppStates {}
class InitState extends AppStates{}

// App Theme
class ThemeModeChangedState extends AppStates{}

// Bottom Nav Bar
class BottomNavBarChangedState extends AppStates{}

// Database (Bookmarks)
class CreateDatabaseLoadingState extends AppStates{}
class CreateDatabaseSuccessState extends AppStates{}
class CreateDatabaseErrorState extends AppStates{}

class CreateTableLoadingState extends AppStates{}
class CreateTableSuccessState extends AppStates{}
class CreateTableErrorState extends AppStates{}

class OpenDatabaseLoadingState extends AppStates{}
class OpenDatabaseSuccessState extends AppStates{}
class OpenDatabaseErrorState extends AppStates{}

class InsertRecordLoadingState extends AppStates{}
class InsertRecordSuccessState extends AppStates{}
class InsertRecordErrorState extends AppStates{}

class GetRecordLoadingState extends AppStates{}
class GetRecordSuccessState extends AppStates{}
class GetRecordErrorState extends AppStates{}

class UpdateRecordLoadingState extends AppStates{}
class UpdateRecordSuccessState extends AppStates{}
class UpdateRecordErrorState extends AppStates{}

class DeleteRecordLoadingState extends AppStates{}
class DeleteRecordSuccessState extends AppStates{}
class DeleteRecordErrorState extends AppStates{}

// News
class TrendingNewsLoadingState extends AppStates{}
class TrendingNewsSuccessState extends AppStates{}
class TrendingNewsErrorState extends AppStates{}

class CategorizedNewsLoadingState extends AppStates{}
class CategorizedNewsSuccessState extends AppStates{}
class CategorizedNewsErrorState extends AppStates{}

class SearchNewsLoadingState extends AppStates{}
class SearchNewsSuccessState extends AppStates{}
class SearchNewsErrorState extends AppStates{}