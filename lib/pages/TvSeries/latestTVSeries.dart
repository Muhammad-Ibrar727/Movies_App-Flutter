import 'package:flutter/material.dart';
import 'package:movies/modals/modal.dart';
import 'package:movies/pages/MovieDetail/detail.dart';
import 'package:movies/services/service.dart';

class Latesttvseries extends StatefulWidget {
  const Latesttvseries({super.key});

  @override
  State<Latesttvseries> createState() => _LatesttvseriesState();
}

class _LatesttvseriesState extends State<Latesttvseries> {
  late Future<List<Movie>> latestTvSeries;

  @override
  void initState() {
    latestTvSeries = ApiServices().getLatestTvSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: FutureBuilder(
            future: latestTvSeries,
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
                  var movie = movies[movies.length - 1 - index];
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/original/${movie.poster_path}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
