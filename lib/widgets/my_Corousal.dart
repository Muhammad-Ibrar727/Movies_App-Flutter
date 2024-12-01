import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCorousal extends StatefulWidget {
  const MyCorousal({super.key});

  @override
  State<MyCorousal> createState() => _SliderState();
}

class _SliderState extends State<MyCorousal> {
  List images = <dynamic>[
    'images/img5.jpg',
    'images/img7.jpg',
    'images/img8.jpg',
    'images/img9.jpg',
    'images/img13.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('slider'),
      ),
      body: Center(
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            // reverse: true,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 0.6,
            pageSnapping: true, //for scrollling the specific

            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            final addressImg = images[index];
            return buildImage(addressImg, index);
          },
        ),
      ),
    );
  }
}

Widget buildImage(String addressImg, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    color: Colors.grey,
    child: Image.asset(
      addressImg,
      fit: BoxFit.cover,
    ),
  );
}
