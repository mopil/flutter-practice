import 'dart:convert';

import 'package:untitled/utils/api_client.dart';
import 'package:untitled/models/board.dart';

class BoardRepository {
  final ApiClient apiClient;

  BoardRepository({required this.apiClient});

  Future<List<Board>> getAllBoards() async {
    try {
      var response = await apiClient.dio.get("/boards/list");
      return (response.data as List<dynamic>)
          .map((item) => Board.fromJson(item))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
