import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/v2/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String option,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(option, queryParameters: query);
  }
}
