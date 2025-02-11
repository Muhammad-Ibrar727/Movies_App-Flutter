import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/pages/MovieDetail/detail.dart';
import 'package:movies/pages/searchScreen/searchScreen.dart';

class Moviespage extends StatefulWidget {
  const Moviespage({super.key});

  @override
  State<Moviespage> createState() => _MoviespageState();
}

class _MoviespageState extends State<Moviespage> {
  late Future<List<dynamic>> movies;

  Future<List<dynamic>> fetchAllMovies() async {
    List<dynamic> allMovies = [];
    int page = 1;
    int maxPages = 10;
    const apiKey = 'Enter your api key';
    while (page <= maxPages) {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        allMovies.addAll(data['results']);
        page++;
      } else {
        throw Exception(' Failed to load the movies');
      }
    }
    return allMovies;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movies = fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All movies'),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Searchscreen(
                                type: 'movie',
                              )));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.search),
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: movies,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<dynamic> movieList = snapshot.data!;
                    return GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: movieList.length,
                      itemBuilder: (context, index) {
                        var movie = movieList[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail(
                                        movieId: movie['id'], type: 'movie')));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
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
                                    child: const Text(
                                      'HD', // "HD" or "Cam"
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ));
  }
}
