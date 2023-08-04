class Board {
  final String title;
  final String contents;
  final String image;

  Board({required this.title, required this.contents, required this.image});

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      title: json['name'],
      contents: json['contents'],
      image: json['image'],
    );
  }
}

class BoardList {
  final List<Board> boards;

  BoardList({required this.boards});

  factory BoardList.fromJson(List<dynamic> parsedJson) {
    List<Board> boards = <Board>[];
    boards = parsedJson.map((i) => Board.fromJson(i)).toList();

    return BoardList(boards: boards);
  }
}
