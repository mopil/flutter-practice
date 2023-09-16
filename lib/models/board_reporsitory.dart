import 'package:dio/dio.dart';
import 'package:untitled/utils/api/api.dart';
import 'package:untitled/models/board.dart';

class BoardRepository {
  final ApiServerConnector apiClient;

  BoardRepository({required this.apiClient});

  Future<List<Board>> getAllBoards() async {
    try {
      Response response = await apiClient.dio.get("/boards");
      return (response.data as List<dynamic>)
          .map((item) => Board.fromJson(item))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
