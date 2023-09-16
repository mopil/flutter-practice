import 'package:flutter/material.dart';

import 'package:untitled/models/test_repository.dart';
import 'package:untitled/utils/api/api.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _controller = TextEditingController();
  final testRepository = TestRepository(server: androidLocalServer);
  Future<String>? statusCodeFuture;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: "http 상태 코드를 입력",
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              int code = int.parse(_controller.text);
              statusCodeFuture = testRepository.getStatusCode(code);
            });
          },
          child: const Text("전송"),
        ),
        FutureBuilder<String>(
          future: statusCodeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // 로딩 중
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // 에러 발생 시
            } else if (!snapshot.hasData) {
              return Text('No data'); // 데이터가 없을 때
            } else {
              return Text('Status Code: ${snapshot.data}'); // 데이터를 받았을 때
            }
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
