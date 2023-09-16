import 'package:dio/dio.dart';
import 'package:untitled/utils/api/api.dart';

class TestRepository {
  final ApiServerConnector server;

  TestRepository({required this.server});

  Future<String> getStatusCode(int code) async {
    try {
      Response response = await server.get("/status/$code");
      return response.statusCode.toString();
    } on DioError catch (e) {
      // 4xx, 5xx 에러는 DioError로 잡힌다
      return e.response?.data["msg"] ?? "알 수 없는 오류";
    }
  }
}
