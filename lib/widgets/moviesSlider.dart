import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SwiperWithStaticButton extends StatefulWidget {
  const SwiperWithStaticButton({super.key});

  @override
  _SwiperWithStaticButtonState createState() => _SwiperWithStaticButtonState();
}

class _SwiperWithStaticButtonState extends State<SwiperWithStaticButton> {
  int _currentIndex = 0;

  // List to track the save state of each movie
  List<bool> isSavedList = [false, false, false];

  final List<Map<String, String>> swiperItems = [
    {
      'title': 'Megalopolis',
      'genre': 'Science Fiction, Drama',
      'image': 'images/img1.jpg', // Replace with actual image paths
      'description': 'A futuristic city with a lot of challenges.',
    },
    {
      'title': 'Joker',
      'genre': 'Thriller, Drama',
      'image': 'images/img5.jpg',
      'description': 'A dark story of a troubled comedian turned villain.',
    },
    {
      'title': 'Arcane',
      'genre': 'Animation, Action',
      'image': 'images/img3.jpg',
      'description': 'A tale of magic and war in a mystical world.',
    },
  ];

  // Show details of the current movie
  void showMovieDetails() {
    final movie = swiperItems[_currentIndex];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(movie['title']!),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Genre: ${movie['genre']}'),
              const SizedBox(height: 10),
              Text('Description: ${movie['description']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Toggle saved/unsaved state for a specific movie
  void toggleSavedState(int index) {
    setState(() {
      isSavedList[index] = !isSavedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CarouselSlider widget
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 0.5,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemCount: swiperItems.length,
            itemBuilder: (context, index, realIndex) {
              final addressImg = swiperItems[index]['image'];
              return buildImage(addressImg!);
            },
          ),

          // Static movie name and genre based on the current index
          const SizedBox(height: 10),
          Text(
            swiperItems[_currentIndex]['title']!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            swiperItems[_currentIndex]['genre']!,
            style: const TextStyle(color: Colors.grey),
          ),

          // Static Buttons Section
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                      onTap: showMovieDetails,
                      child: const Icon(Icons.details)),
                  const SizedBox(height: 4),
                  const Text('Detail')
                ],
              ),
              InkWell(
                onTap: () {
                  final movie = swiperItems[_currentIndex];
                  print("Watching: ${movie['title']}");
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'Watch Now',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              // Save List Icon (Bookmark icon with toggle functionality)
              GestureDetector(
                onTap: () => toggleSavedState(
                    _currentIndex), // Toggle save state for the current movie
                child: Column(
                  children: [
                    Icon(
                      isSavedList[_currentIndex]
                          ? Icons.bookmark
                          : Icons
                              .bookmark_border, // Change icon based on save state
                      color: isSavedList[_currentIndex]
                          ? Colors.green
                          : Colors.blue, // Change color based on save state
                      size: 30,
                    ),
                    const Text('Add List')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage(String addressImg) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          addressImg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
