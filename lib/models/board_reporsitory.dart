import '../utils/api_client.dart';
import 'board_model.dart';

class BoardRepository {
  final ApiClient apiClient;

  BoardRepository({required this.apiClient});

  Future<List<Board>> getAllBoards() async {
    return apiClient.get<List<Board>>("/boards/list");
  }
}
