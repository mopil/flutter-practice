import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/image_util.dart';
import 'package:untitled/widgets/bookmark_button.dart';
import 'package:untitled/widgets/expandable_text.dart';
import 'package:untitled/widgets/like_button.dart';

final imageUrls = [
  "https://fastly.picsum.photos/id/571/600/600.jpg?hmac=Rv054NyAim_PdRdyYprAShHy4DJn49qWBtIfpP1q7eM",
  "https://fastly.picsum.photos/id/571/600/600.jpg?hmac=Rv054NyAim_PdRdyYprAShHy4DJn49qWBtIfpP1q7eM",
  "https://fastly.picsum.photos/id/571/600/600.jpg?hmac=Rv054NyAim_PdRdyYprAShHy4DJn49qWBtIfpP1q7eM",
  "https://fastly.picsum.photos/id/571/600/600.jpg?hmac=Rv054NyAim_PdRdyYprAShHy4DJn49qWBtIfpP1q7eM",
  "https://fastly.picsum.photos/id/571/600/600.jpg?hmac=Rv054NyAim_PdRdyYprAShHy4DJn49qWBtIfpP1q7eM",
];

class InstagramFeedScreen extends StatefulWidget {
  const InstagramFeedScreen({Key? key}) : super(key: key);

  @override
  State<InstagramFeedScreen> createState() => _InstagramFeedScreenState();
}

class _InstagramFeedScreenState extends State<InstagramFeedScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Widget _instagramFeed() {
    double width = MediaQuery.of(context).size.width;
    return ListTile(
      title: const Text("Instagram"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 350, // 이거 왜 여기다 배치해야 인디케이터 아래로 감??
            child: Stack(
              children: [
                sliderWidget(),
                sliderIndicator(),
                Positioned(
                    bottom: 0, left: width * 0.1, child: const LikeButton()),
                Positioned(
                  bottom: 0,
                  left: width * 0.2,
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.chat_bubble),
                    onPressed: () {
                      // 버튼이 클릭되었을 때 수행할 작업
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: width * 0.3,
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // 버튼이 클릭되었을 때 수행할 작업
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: width * 0.1,
                  child: const BookmarkButton(),
                ),
              ],
            ),
          ),
          const Text("좋아요 100개"),
          const ExpandableText(
              content: "여기에는 대충 글 내용이 적어짐 이 글은 너무나도 길어서 다 못담기 떄문에 더보기를 눌러야함"),
          const Text("3일 전",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _instagramListView(List feeds) {
    return ListView.builder(
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        return _instagramFeed();
      },
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
        carouselController: _controller,
        items: imageUrls.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
            height: 300,
            viewportFraction: 1.0,
            // autoPlay: false,
            // enlargeCenterPage: true, // 슬라이드할 때 약간 에니메이션이 들어감
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }));
  }

  Widget sliderIndicator() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageUrls.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: (_current == entry.key ||
                        _current == entry.key + 1 ||
                        _current == entry.key - 1)
                    ? 12.0
                    : 6.0,
                height: (_current == entry.key ||
                        _current == entry.key + 1 ||
                        _current == entry.key - 1)
                    ? 12.0
                    : 6.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue
                      .withOpacity(_current == entry.key ? 0.9 : 0.1),
                ),
              ),
            );
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Instagram"),
        ),
        body: _instagramListView(getDummyImageList()));
  }
}
