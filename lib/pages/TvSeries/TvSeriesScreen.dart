import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/pages/MovieDetail/detail.dart';
import 'package:movies/pages/searchScreen/searchScreen.dart';

class allTvSeries extends StatefulWidget {
  const allTvSeries({super.key});

  @override
  State<allTvSeries> createState() => _allTvSeriesState();
}

class _allTvSeriesState extends State<allTvSeries> {
  // late Future<List<dynamic>> movies;
  late Future<List<dynamic>> tvseries;

  Future<List<dynamic>> fetchAllTvSeries() async {
    List<dynamic> allTvSeries = [];
    int page = 1;
    int maxPages = 10;
    const apiKey = 'Enter your api key';
    while (page <= maxPages) {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/discover/tv?api_key=$apiKey&page=$page'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        allTvSeries.addAll(data['results']);
        page++;
      } else {
        throw Exception(' Failed to load the movies');
      }
    }
    return allTvSeries;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tvseries = fetchAllTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Tv Series'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Searchscreen(type: 'tv')));
                  },
                  child: const Icon(Icons.search_rounded)),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: tvseries,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<dynamic> tvSeriesList = snapshot.data!;
                    return GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: tvSeriesList.length,
                      itemBuilder: (context, index) {
                        var TvSeries = tvSeriesList[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail(
                                        movieId: TvSeries['id'],
                                        type: 'movie')));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  'https://image.tmdb.org/t/p/w200${TvSeries['poster_path']}',
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
