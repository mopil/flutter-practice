import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/image_util.dart';

final imageUrls = [
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
    return ListTile(
      title: const Text("Instagram"),
      subtitle: Column(
        children: [
          SizedBox(
            height: 300, // 이거 왜 여기다 배치해야 인디케이터 아래로 감??
            child: Stack(
              children: [
                sliderWidget(),
                sliderIndicator(),
              ],
            ),
          ),
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
            autoPlay: false,
            enlargeCenterPage: true, // 슬라이드할 때 약간 에니메이션이 들어감
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
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
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
