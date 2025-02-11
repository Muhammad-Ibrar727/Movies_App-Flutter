import 'package:flutter/material.dart';
import 'package:movies/pages/TvSeries/allTvSeries.dart';
import 'package:movies/pages/TvSeries/latestTVSeries.dart';
import 'package:movies/pages/searchScreen/searchScreen.dart';
import 'package:movies/widgets/moviesSlider.dart';
import 'package:movies/pages/popularMovies/popularMovies.dart';
import 'package:movies/pages/TopRatedMovies/topRated.dart';
import 'package:movies/pages/UpcommingMovies/upcomming.dart';

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
              const CircleAvatar(
                backgroundImage: AssetImage('images/appLogo.jpg'),
                radius: 14,
              ),
              const SizedBox(width: 12),
              // Text(
              //   'MoviGo',
              //   style: TextStyle(fontSize: 17, letterSpacing: 2),
              // ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'BankGothic',
                    fontSize: 23   ,
                  ),
                  children: [
                    TextSpan(
                      text: 'Movi',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Go',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Searchscreen(type: 'movie')));
              },
              child: const Icon(Icons.search)),
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
          // "Trending" and "Popular" section
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
                    Navigator.pushNamed(context, '');
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

                  //movies slider or carousal
                  const MoviesSlider(),

                  // Upcoming Movies Section
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Upcoming Movies',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'allUpcommingMovies');
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(fontSize: 12, color: Colors.amber),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const UpcommingMovies(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Rated Movies',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'allTopRatedMovies');
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(fontSize: 12, color: Colors.amber),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const TopRated(),

                  // popular
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
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'allPopularMovies');
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(fontSize: 12, color: Colors.amber),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Popularmovies(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Latest TV Series',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Alltvseries()));
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(fontSize: 12, color: Colors.amber),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Latesttvseries(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
