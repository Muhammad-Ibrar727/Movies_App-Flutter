import 'package:flutter/material.dart';
import 'package:movies/DisplayAllMovies/allMovies.dart';

class AllTopRatedMovies extends StatefulWidget {
  const AllTopRatedMovies({super.key});

  @override
  State<AllTopRatedMovies> createState() => _AllTopRatedMoviesState();
}

class _AllTopRatedMoviesState extends State<AllTopRatedMovies> {
  late Future<List<dynamic>> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leadingWidth: 20,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(Icons.arrow_back_ios_new_rounded),
                )),
            title: const Text('TopRated Movies')),
        body: AllMovies(moviesType: 'top_rated'));
  }
}
