import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/pages/MovieDetail/detail.dart';

class TrendingMoviesScreen extends StatefulWidget {
  const TrendingMoviesScreen({super.key});

  @override
  _TrendingMoviesScreenState createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  String selectedCategory = 'day';
  List movies = [];
  bool isLoading = true;

  final String apiKey = 'Enter your api key';

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies(); // Fetch movies when the screen loads
  }

  // Fetch trending movies from TMDB
  Future<void> fetchTrendingMovies() async {
    setState(() {
      isLoading = true;
    });

    final url =
        'https://api.themoviedb.org/3/trending/movie/$selectedCategory?api_key=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies = data['results'];
        });
      }
    } catch (error) {
      print('Error fetching movies: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        leadingWidth: 20,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(Icons.arrow_back_ios_new_rounded),
            )),
      ),
      body: Column(
        children: [
          // Toggle buttons for Day/Week
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildCategoryButton('day', 'Day'),
              _buildCategoryButton('week', 'Week'),
            ],
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : movies.isEmpty
                    ? const Center(child: Text('No movies found.'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetail(
                                            movieId: movie['id'],
                                            type: 'movie',
                                          )));
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
                      ),
          ),
        ],
      ),
    );
  }

  // Button for selecting category
  Widget _buildCategoryButton(String category, String label) {
    return TextButton(
      onPressed: () {
        if (selectedCategory != category) {
          setState(() {
            selectedCategory = category;
          });
          fetchTrendingMovies();
        }
      },
      child: Text(
        label,
        style: TextStyle(
          color: selectedCategory == category ? Colors.yellow : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
