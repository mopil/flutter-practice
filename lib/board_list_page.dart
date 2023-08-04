import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/api_client.dart';

import 'models/board_model.dart';
import 'models/board_reporsitory.dart';

class BoardListPage extends StatelessWidget {
  const BoardListPage({Key? key}) : super(key: key);
  //

  @override
  Widget build(BuildContext context) {
    final boardRepository =
        BoardRepository(apiClient: Provider.of<ApiClient>(context));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("게시판 목록"),
      ),
      body: FutureBuilder<List<Board>>(
        future: boardRepository.getAllBoards(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const Center(
              child: Text("데이터를 불러오는데 실패했습니다."),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data![index].contents),
                      Text(snapshot.data![index].image),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
