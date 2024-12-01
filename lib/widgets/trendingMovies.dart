import 'package:flutter/material.dart';

class Trendingmovies extends StatelessWidget {
  Trendingmovies({super.key});

  final List<Map<String, String>> movies = [
    {
      'title': 'Megalopolis',
      'image': 'images/img1.jpg',
    },
    {
      'title': 'Joker',
      'image': 'images/img4.jpg',
    },
    {
      'title': 'Arcane',
      'image': 'images/img3.jpg',
    },
    {
      'title': 'Arcane',
      'image': 'images/img5.jpg',
    },
    {
      'title': 'Arcane',
      'image': 'images/img6.jpg',
    },
    {
      'title': 'Arcane',
      'image': 'images/img7.jpg',
    },
    {
      'title': 'Arcane',
      'image': 'images/img8.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          var movie = movies[index];
          var title = movie['title'] ?? 'Untitled Movie';
          var image = movie['image'] ?? 'images/img1.jpg';
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(title)
              ],
            ),
          );
        },
      ),
    );
  }
}
