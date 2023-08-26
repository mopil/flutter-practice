import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String content;

  const ExpandableText({Key? key, required this.content}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String displayText = widget.content;
    String ellipsis = "...";
    String toggleText = "더보기";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          // 텍스트 중 일부에 스타일링을 하려면 이 위젯을 사용
          text: TextSpan(children: <TextSpan>[
            // RichText와 짝꿍
            TextSpan(
              text: _isExpanded
                  ? displayText
                  : (widget.content.length <= 30
                      ? widget.content
                      : widget.content.substring(0, 30)),
              style: const TextStyle(color: Colors.black87),
            ),
            if (!_isExpanded)
              TextSpan(
                text: ellipsis,
                style: const TextStyle(color: Colors.black87),
              ),
            if (!_isExpanded)
              TextSpan(
                text: toggleText,
                style: const TextStyle(color: Colors.grey),
                recognizer: TapGestureRecognizer()..onTap = _toggleExpanded,
              ),
          ]),
        )
      ],
    );
  }
}
