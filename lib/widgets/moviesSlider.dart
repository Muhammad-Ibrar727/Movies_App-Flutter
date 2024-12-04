import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/modals/Genres_model.dart';
import 'package:movies/modals/modal.dart';
import 'package:movies/services/genre.dart';
import 'package:movies/services/service.dart';

class SwiperWithStaticButton extends StatefulWidget {
  const SwiperWithStaticButton({super.key});

  @override
  _SwiperWithStaticButtonState createState() => _SwiperWithStaticButtonState();
}

class _SwiperWithStaticButtonState extends State<SwiperWithStaticButton> {
  int _currentIndex = 0;
  // late Future<List<Movie>> nowPlaying;
  // Future<List<Movie>> nowPlaying = Future.value([]);
  Future<List<Movie>> popularMovies = Future.value([]);

  Future<List<Genre>> genres = Future.value([]);

  @override
  void initState() {
    super.initState();
    genres = GenreServices().fetchGenres();
    // nowPlaying = ApiServices().getNowPlaying();
    popularMovies = ApiServices().getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<List<Movie>>(
            future: popularMovies,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final movies = snapshot.data!;

              // Handle case where no movies are available
              if (movies.isEmpty) {
                return const Center(
                  child: Text(
                    'No movies available',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return Column(
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.37,
                      // height: 340,
                      // aspectRatio: 16 / 9,
                      aspectRatio: 0.3,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 0.6,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        if (movies.isNotEmpty) {
                          setState(() {
                            _currentIndex = index % movies.length;
                          });
                        }
                      },
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index, movieIndex) {
                      final movie = movies[index];
                      return Container(
                        height: 310,
                        width: 210,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/original/${movie.backDropPath}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  // Movie title displayed here (before buttons)
                  Text(
                    movies[_currentIndex].title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // for genres
                  FutureBuilder(
                      future: genres,
                      builder: (contex, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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

                        //for one genre from the list of ids [23,4,5]
                        // final movieGenre = allGenres[_currentIndex].name;

                        return Text(
                            movieGenres
                                .join(', '), // Join genre names with commas
                            style: const TextStyle(
                              fontSize: 12,
                            ));
                      })
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Icon(Icons.details),
                  SizedBox(height: 4),
                  Text('Detail'),
                ],
              ),
              InkWell(
                onTap: () {
                  // Static "Watch Now" functionality
                  final movie =
                      popularMovies.then((movies) => movies[_currentIndex]);
                  movie.then((movie) {
                    print("Watching: ${movie.title}");
                  });
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
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.blue,
                    size: 30,
                  ),
                  Text('Add List'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
