import 'package:flutter/material.dart';

import 'package:movies/DisplayAllMovies/allMovies.dart';

class AllPopularMovies extends StatefulWidget {
  const AllPopularMovies({super.key});

  @override
  State<AllPopularMovies> createState() => _AllPopularMoviesState();
}

class _AllPopularMoviesState extends State<AllPopularMovies> {
  late Future<List<dynamic>> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Popular movies'),
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
        body: AllMovies(moviesType: 'popular'));
  }
}
