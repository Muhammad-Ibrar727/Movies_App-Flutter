import 'package:flutter/material.dart';
import 'package:movies/widgets/latestTVSeries.dart';
import 'package:movies/widgets/moviesSlider.dart';
import 'package:movies/widgets/popularMovies.dart';
import 'package:movies/widgets/trendingMovies.dart';
import 'package:movies/widgets/upcomming.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                radius: 20,
                child: const Icon(Icons.theater_comedy),
              ),
              const SizedBox(width: 12),
              const Text('MyMovies'),
            ],
          ),
        ),
        actions: [
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'signupAndLogin');
                },
                child:
                    const CircleAvatar(radius: 13, child: Icon(Icons.person))),
          ),
        ],
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
                  onTap: () {
                    Navigator.pushNamed(context, 'trendingMovies');
                  },
                  child: const Text(
                    'Trending',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'popularMovies');
                  },
                  child: const Text(
                    'Popular',
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const SwiperWithStaticButton(),

                  // Upcoming Movies Section
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming Movies',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(fontSize: 12, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  UpcommingMovies(),

                  // Trending Movies Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trending Movies',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'trendingMovies');
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(fontSize: 12, color: Colors.amber),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Trendingmovies(),

                  // Other sections...
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'popularMovies');
                          },
                          child: const Text(
                            'Popular Movies',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Text(
                          'See All',
                          style: TextStyle(fontSize: 12, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                  Popularmovies(),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Latest TV Series',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(fontSize: 12, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                  Latesttvseries(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
