import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiClient {
  late Dio dio;

  ApiClient(String baseUrl) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
    initializeInterceptors();
  }

  void initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (options, handler) {
          log('RESPONSE[${options.statusCode}] => PATH: ${options.data}');
          return handler.next(options); // continue
        },
        onError: (DioError e, handler) {
          log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          return handler.next(e);
        },
      ),
    );
  }

  T fromJson<T>(dynamic data) {
    if (data is Iterable) {
      return data.map((item) => fromJson<T>(item)).toList() as T;
    } else if (T == dynamic) {
      return data as T;
    } else {
      var jsonDecode = json.decode(data);
      return jsonDecode as T;
    }
  }

  Future<T> get<T>(String uri, {Map<String, dynamic>? queryParameters}) async {
    var response = await dio.get(uri, queryParameters: queryParameters);
    return fromJson<T>(response.data);
  }
}
