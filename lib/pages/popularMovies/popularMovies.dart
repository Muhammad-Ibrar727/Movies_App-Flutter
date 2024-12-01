import 'package:flutter/material.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Column(
        children: [
          // Static "Trending" and "Popular" section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Day',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Week',
                ),
              ],
            ),
          ),

          const Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ))
        ],
      ),
    );
  }
}
