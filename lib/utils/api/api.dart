import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiServerConnector {
  late Dio dio;

  ApiServerConnector(String baseUrl) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
    setInterceptors();
  }

  void setInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Authorization"] = "Bearer jwt_token";
          log("REQUEST :: ${options.method} ${options.path} :: DATA: ${jsonEncode(options.data)}");
          return handler.next(options);
        },
        onResponse: (options, handler) {
          log("RESPONSE :: ${options.statusCode} = ${options.data}");
          return handler.next(options);
        },
        onError: (DioError e, handler) {
          log("API CALL FAILED [${e.response?.statusCode}] => PATH: ${e.requestOptions.path} :: ${e.response?.data["msg"]}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) {
    return dio.post(path, queryParameters: queryParameters, data: data);
  }

  Future<Response<T>> put<T>(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) {
    return dio.put(path, queryParameters: queryParameters, data: data);
  }

  Future<Response<T>> delete<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    return dio.delete(path, queryParameters: queryParameters);
  }
}

final localServer = ApiServerConnector("http://localhost:8080");
final androidLocalServer = ApiServerConnector("http://10.0.2.2:8080");
