import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class BookmarksCubit extends Cubit<AppStates> {
  BookmarksCubit() : super(InitState());

  // Cubit getter
  BookmarksCubit get(context) => BlocProvider.of(context);

  //Cubit vars
  late Database database;
  List<dynamic> bookmarksList=[];

  //Cubit methods
  void createBookmarksDatabase() async {
    database = await openDatabase(
      "bookmarks.db",
      version: 1,
      onCreate: (Database db, int version) {
        emit(CreateDatabaseSuccessState());

        emit(CreateTableLoadingState());
        // Create Bookmarks table
        db
            .execute(
                'CREATE TABLE Bookmarks (id INTEGER PRIMARY KEY, title TEXT, publishedAt TEXT, author TEXT, urlToImage TEXT, url TEXT)')
            .then((value) => emit(CreateTableSuccessState()))
            .catchError((onError) => emit(CreateTableErrorState()));
      },
      onOpen: (Database db) {
        emit(OpenDatabaseSuccessState());
      },
    );
    // return database;
  }

  void insertRecord(
      {required String title,
      required String date,
      required String source,
      required String image,
      required String link}) {
    emit(InsertRecordLoadingState());
    database
        .transaction((txn) => txn.rawInsert(
            'INSERT INTO Bookmarks(title, publishedAt, author, urlToImage, url) VALUES("$title","$date","$source","$image","$link")'))
        .then((value) => emit(InsertRecordSuccessState()))
        .catchError((onError) => emit(InsertRecordErrorState()));
  }

  // Future<List<dynamic>> getDataFromDatabase(database) async
  // {
  //   emit(GetRecordLoadingState());
  //   return await database.rawQuery('SELECT * FROM Bookmarks');
  // }

  void getDataFromDatabase() {
    emit(GetRecordLoadingState());

    database.rawQuery('SELECT * FROM Bookmarks').then((value) {
      bookmarksList.clear();
      for(int i=0;i<value.length;i++){
        bookmarksList.add(value[i]);
      }
      print(bookmarksList);
      emit(GetRecordSuccessState());
    }).catchError((onError)=>emit(GetRecordErrorState()));
  }

// Future<List<dynamic>> getRecords() {
//   Future<List<dynamic>> bookmarks=database.rawQuery('SELECT * FROM Bookmarks');
//   return bookmarks;
// }

// void updateRecord() {}

  void deleteRecord() {}
}
