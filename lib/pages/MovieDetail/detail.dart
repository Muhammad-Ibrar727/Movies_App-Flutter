import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/modals/casteModel.dart';
import 'package:movies/pages/MovieDetail/casts.dart';
import 'package:movies/pages/MovieDetail/recommended.dart';
import 'package:movies/services/casteservice.dart';
import 'package:movies/pages/TrailerScreen/trailerScreen.dart';

class MovieDetail extends StatefulWidget {
  final String type;
  final int movieId;

  const MovieDetail({super.key, required this.movieId, required this.type});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late Future<Map<String, dynamic>> movieDetails;
  late Future<List<Cast>> getCast = Future.value([]);

  @override
  void initState() {
    final apiService = ApiService();
    super.initState();
    movieDetails = getDetails(widget.movieId, widget.type);
    getCast = apiService.fetchCast(widget.movieId, widget.type);
  }

  Future<Map<String, dynamic>> getDetails(int movieId, String type) async {
    const apiKey = 'Enter your api key';

    final url = 'https://api.themoviedb.org/3/$type/$movieId?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: movieDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No movie details found.'));
            }

            final aboutMovie = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 400,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    // title
                    background: Stack(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/original/${aboutMovie['backdrop_path']}',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 175,
                            left: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MovieTrailerScreen(
                                                MovieId: widget.movieId,
                                                type: widget.type)));
                              },
                              child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.3),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                  )),
                            )),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0, // Ensures centering across the full width
                          child: Center(
                            // Centers the Column on the image
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 400,
                                  child: Text(
                                    aboutMovie['title'] ?? '',
                                    textAlign: TextAlign
                                        .center, // Ensures text is centered when wrapping
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${aboutMovie['release_date']?.split('-')[0] ?? ''} • ${aboutMovie['genres']?[0]['name'] ?? 'Genre'} • ${aboutMovie['runtime'] ?? '100'} min',
                                  textAlign: TextAlign
                                      .center, // Centers this text as well
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 20),
                                  const SizedBox(width: 5),
                                  Text(
                                    aboutMovie['vote_average']
                                            ?.toStringAsFixed(1) ??
                                        'N/A',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.amber),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "(${aboutMovie['vote_count'] ?? 'N/A'} voted)", // Fallback to 'N/A' if null
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                            const Row(
                              children: [
                                Icon(Icons.share, color: Colors.white),
                                SizedBox(width: 15),
                                Icon(Icons.bookmark, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          aboutMovie['tagline'] ?? 'No Tagline',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Overview",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          aboutMovie['overview'] ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Genre",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          aboutMovie['genres'] != null
                              ? (aboutMovie['genres'] as List)
                                  .map((genre) => genre['name'])
                                  .join(
                                      ', ') // Join all genre names with a comma
                              : 'No genres available', //  in case the genres list is null
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Cast",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        //shows the casts of the movie
                        getcasts(movieId: widget.movieId, type: widget.type),

                        const SizedBox(height: 20),

                        //recommended movies
                        const Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RecommendedMovies(
                          movieId: widget.movieId,
                          type: widget.type,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
