import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/modals/Genres_model.dart';
import 'package:movies/modals/modal.dart';
import 'package:movies/pages/MovieDetail/detail.dart';
import 'package:movies/pages/TrailerScreen/trailerScreen.dart';
import 'package:movies/services/genre.dart';
import 'package:movies/services/service.dart';

class MoviesSlider extends StatefulWidget {
  const MoviesSlider({super.key});

  @override
  _MoviesSliderState createState() => _MoviesSliderState();
}

class _MoviesSliderState extends State<MoviesSlider> {
  int _currentIndex = 0;
  // Future<List<Movie>> nowPlaying = Future.value([]);
  Future<List<Movie>> nowPlaying = Future.value([]);
  Future<List<Movie>> sliderMovies = Future.value([]);
  Future<List<Genre>> genres = Future.value([]);

  @override
  void initState() {
    super.initState();
    genres = GenreServices().fetchGenres();
    nowPlaying = ApiServices().getNowPlaying();
    sliderMovies = ApiServices().getMoviesForSlider(1);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<List<Movie>>(
              future: sliderMovies,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  // print(snapshot.data);
                  return const Center(child: CircularProgressIndicator());
                }

                final movies = snapshot.data!;
                // Handle case where no movies are available
                if (movies.isEmpty) {
                  return const Center(
                    child: Text('No movies available',
                        style: TextStyle(fontSize: 18)),
                  );
                } else {
                  return Column(
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.37,
                          aspectRatio: 0.3,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index % snapshot.data!.length;
                            });
                          },
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index, movieIndex) {
                          final movie = movies[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetail(
                                          movieId: movie.id, type: 'movie')));
                            },
                            child: Container(
                              height: 310,
                              width: 210,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/original/${movie.poster_path}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),
                      //title of the button
                      Text(
                        movies[_currentIndex].title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // for genres
                      FutureBuilder(
                        future: genres,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final allGenres = snapshot.data ?? [];
                          final movieGenres = movies[_currentIndex]
                              .genre_ids
                              .map((id) => allGenres
                                  .firstWhere((genre) => genre.id == id,
                                      orElse: () =>
                                          Genre(id: id, name: 'Unknown'))
                                  .name)
                              .toList();
                          return Text(movieGenres.join(', '),
                              style: const TextStyle(fontSize: 12));
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (movies.isNotEmpty) {
                                      final movieId = movies[_currentIndex]
                                          .id; // Get the movie ID of the current movie to display the movie info
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MovieDetail(
                                              movieId: movieId, type: 'movie'),
                                        ),
                                      );
                                    }
                                  },
                                  child:
                                      const Icon(Icons.info_outline, size: 25)),
                              const SizedBox(height: 4),
                              const Text('Detail'),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if (movies.isNotEmpty) {
                                final movieId = movies[_currentIndex]
                                    .id; // Get the movie ID of the current movie to watch the trailer
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieTrailerScreen(
                                      MovieId: movieId,
                                      type: 'movie',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Watch Now',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          const Column(
                            children: [
                              Icon(Icons.favorite_border, size: 25),
                              SizedBox(
                                height: 4,
                              ),
                              Text('Favorite'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
