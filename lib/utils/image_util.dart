import 'package:flutter/material.dart';

List<Image> getDummyImageList() {
  List<Image> images = [];
  for (int i = 0; i < 50; i++) {
    images.add(Image.network(
      "https://fastly.picsum.photos/id/571/600/600.jpg?hmac=Rv054NyAim_PdRdyYprAShHy4DJn49qWBtIfpP1q7eM",
      fit: BoxFit.cover,
    ));
  }
  return images;
}
