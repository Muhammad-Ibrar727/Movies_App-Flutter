import 'package:flutter/material.dart';
import 'package:movies/modals/modal.dart';
import 'package:movies/pages/MovieDetail/detail.dart';
import 'package:movies/services/service.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  late Future<List<Movie>> topRated;

  @override
  void initState() {
    topRated = ApiServices().getTopRated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: FutureBuilder(
            future: topRated,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final movies = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  var movie = movies[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                        movieId: movie.id, type: "movie")));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              height: 150,
                              width: 100,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original/${movie.poster_path}',
                                fit: BoxFit.cover,
                              ),
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
