import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/modals/modal.dart';
import 'package:movies/pages/MovieDetail/detail.dart';

class RecommendedMovies extends StatefulWidget {
  int? movieId;
  final String type;
  RecommendedMovies({super.key, this.movieId, required this.type});

  @override
  State<RecommendedMovies> createState() => _RecommendedMoviesState();
}

class _RecommendedMoviesState extends State<RecommendedMovies> {
  late Future<List<Movie>> RecommendedMovies;
  @override
  void initState() {
    RecommendedMovies = getRecommended(widget.movieId, widget.type);
    super.initState();
  }

  Future<List<Movie>> getRecommended(movieId, type) async {
    const apiKey = 'Enter your api key';
    final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/$type/$movieId/recommendations?api_key=$apiKey',
    ));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: FutureBuilder(
            future: RecommendedMovies,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final movies = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  var movie = movies[movies.length - 1 - index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail(
                                          movieId: movie.id,
                                          type: 'movie',
                                        )));
                          },
                          child: Container(
                            height: 150,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/original/${movie.poster_path}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }));
  }
}
