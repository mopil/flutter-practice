import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/api_client.dart';

import 'package:untitled/models/board.dart';
import 'package:untitled/models/board_reporsitory.dart';

import 'package:untitled/utils/toast.dart';

class BoardListScreen extends StatefulWidget {
  const BoardListScreen({Key? key}) : super(key: key);

  @override
  State<BoardListScreen> createState() => _BoardListScreenState();
}

class _BoardListScreenState extends State<BoardListScreen> {
  late Future<List<Board>> _boardsFuture;
  late BoardRepository _boardRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeRepository();
    _refreshBoards();
  }

  void _initializeRepository() {
    _boardRepository =
        BoardRepository(apiClient: Provider.of<ApiClient>(context));
  }

  Future<void> _refreshBoards() async {
    _boardsFuture = _boardRepository.getAllBoards();
    showToast(message: "게시판 목록을 새로고침 했습니다.");
    setState(() {});
  }

  Widget _buildBoardListTile(Board board) {
    return ListTile(
      title: Text(board.title),
      subtitle: Row(
        children: [
          Text(board.content),
          Image.network(board.image, width: 100, height: 100)
        ],
      ),
    );
  }

  Widget _buildBoardListView(List<Board> boards) {
    return ListView.builder(
      itemCount: boards.length,
      itemBuilder: (context, index) {
        return _buildBoardListTile(boards[index]);
      },
    );
  }

  Widget _buildErrorState() {
    return const Center(
      child: Text("게시판 목록을 불러오는 중에 에러가 발생했습니다."),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildBoardList() {
    return FutureBuilder<List<Board>>(
      future: _boardsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildBoardListView(snapshot.data!);
        } else if (snapshot.hasError) {
          log("board list fetching failed : ${snapshot.error}, ${snapshot.stackTrace}");
          return _buildErrorState();
        }
        return _buildLoadingState();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("게시판 목록"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshBoards,
          ),
        ],
      ),
      body: _buildBoardList(),
    );
  }
}

