import 'package:flutter/material.dart';
import 'package:movies/DisplayAllMovies/allMovies.dart';

class Alltvseries extends StatefulWidget {
  const Alltvseries({super.key});

  @override
  State<Alltvseries> createState() => _AllTopRatedMoviesState();
}

class _AllTopRatedMoviesState extends State<Alltvseries> {
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
            title: const Text('Latest Tv Series')),
        body: AllMovies(moviesType: 'tv'));
  }
}
