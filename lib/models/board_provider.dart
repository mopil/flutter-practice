import 'package:flutter/cupertino.dart';
import 'package:untitled/models/board_reporsitory.dart';

import 'package:untitled/utils/api/api.dart';
import 'package:untitled/models/board.dart';

class BoardProvider with ChangeNotifier {
  final boardRepository =
      BoardRepository(apiClient: context.read<ApiServerConnector>());
  List<Board> _boardList = [];
  Board? _boardDetail;

  List<Board> get boardList => _boardList;
  Board? get boardDetail => _boardDetail;

  static get context => null;

  getAllBoards() async {
    List<Board> boards = await boardRepository.getAllBoards();
    _boardList.addAll(boards);
    notifyListeners();
  }

  // getBoard(int id) async {
  //   _boardDetail = await boardRepository.getBoard(id);
  //   notifyListeners();
  // }
}
