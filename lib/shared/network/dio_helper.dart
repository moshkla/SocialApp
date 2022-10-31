import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? qurey,
    String lang = 'en',
    String? token,
  }) async {
    dio.options .headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(url, queryParameters: qurey);
  }

  static Future<Response> postData({
    required url,
    Map<String, dynamic>? qurey,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(url, queryParameters: qurey, data: data);
  }

  static Future<Response> putData({
    required url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? qurey,
    String lang = 'en',
    String? token,
  }) async {
    dio.options .headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.put(url, queryParameters: qurey, data: data);
  }
}
