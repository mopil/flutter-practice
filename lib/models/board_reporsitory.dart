import 'package:untitled/utils/api_client.dart';
import 'package:untitled/models/board_model.dart';

class BoardRepository {
  final ApiClient apiClient;

  BoardRepository({required this.apiClient});

  Future<List<Board>> getAllBoards() async {
    return apiClient.get<List<Board>>("/boards/list");
  }
}
