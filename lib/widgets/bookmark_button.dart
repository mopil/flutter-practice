import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({Key? key}) : super(key: key);

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
      ),
      onPressed: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
      },
    );
  }
}
