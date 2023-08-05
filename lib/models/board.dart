class Board {
  final String title;
  final String content;
  final String image;

  Board({required this.title, required this.content, required this.image});

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      title: json['title'],
      content: json['content'],
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
