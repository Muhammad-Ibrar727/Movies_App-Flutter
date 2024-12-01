import 'package:flutter/material.dart';
import 'package:movies/pages/moviesPage.dart';

class TrendingMovies extends StatelessWidget {
  TrendingMovies({super.key});
  final List<Map<String, String>> movies = [
    {
      'image': 'images/img1.jpg', // Replace with actual image paths
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
      'image': 'images/img7.jpg', // Replace with actual image paths
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
    // Add more images here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Movies'),
      ),
      body: Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns in the grid
            crossAxisSpacing: 10.0, // Horizontal spacing between images
            mainAxisSpacing: 10.0, // Vertical spacing between images
            childAspectRatio:
                0.75, // Aspect ratio of each grid item (width/height)
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            var movie = movies[index];
            var image = movie['image']!;
            var quality = movie['quality']!;

            return ClipRRect(
              borderRadius: BorderRadius.circular(8), // Rounded corners
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Image.asset(
                    image,
                    fit: BoxFit.cover, // Fill the container
                  ),
                  // Overlay Text (HD or Cam)
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
      ),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       InkWell(
      //         onTap: () {},
      //         child: const Text(
      //           'Day',
      //           style: TextStyle(fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //       const SizedBox(
      //         width: 20,
      //       ),
      //       const Text(
      //         'Week',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
