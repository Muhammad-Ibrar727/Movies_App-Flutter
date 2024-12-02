import 'package:flutter/material.dart';

class MovieGridPage extends StatelessWidget {
  MovieGridPage({super.key});

  final List<Map<String, String>> movies = [
    {
      'image': 'images/img1.jpg',
      'quality': 'HD',
    },
    {
      'image': 'images/img3.jpg',
      'quality': 'Cam',
    },
    {
      'image': 'images/img4.jpg',
      'quality': 'HD',
    },
    {
      'image': 'images/img5.jpg',
      'quality': 'Cam',
    },
    {
      'image': 'images/img6.jpg',
      'quality': 'HD',
    },
    {
      'image': 'images/img7.jpg',
      'quality': 'HD',
    },
    {
      'image': 'images/img8.jpg',
      'quality': 'Cam',
    },
    {
      'image': 'images/img9.jpg',
      'quality': 'HD',
    },
    {
      'image': 'images/img10.jpg',
      'quality': 'Cam',
    },
    {
      'image': 'images/img1.jpg',
      'quality': 'HD',
    },
    {
      'image': 'images/img4.jpg',
      'quality': 'Cam',
    },
    {
      'image': 'images/img7.jpg',
      'quality': 'HD',
    },
    {
      'image': 'images/img5.jpg',
      'quality': 'Cam',
    },
    {
      'image': 'images/img6.jpg',
      'quality': 'HD',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [Text('MyMovies'), Spacer(), Icon(Icons.search)],
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          var movie = movies[index];
          var image = movie['image']!;
          var quality = movie['quality']!;

          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      quality, // "HD" or "Cam"
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
