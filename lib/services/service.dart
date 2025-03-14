import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/modals/modal.dart';

const api_key = "Enter your api key";

class ApiServices {
  final nowplaying =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$api_key';
  final upComingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$api_key";
  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$api_key";
  final topRatedApi =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$api_key";
  final sliderApi =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$api_key&page=3";
  final latestTvSeriesApi =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$api_key";

  //for the nowPlaying
  Future<List<Movie>> getNowPlaying() async {
    Uri url = Uri.parse(nowplaying);
    final response = await http.get(url);

    //for checking the data from the api
    // print('API Response (Movies): ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data
          .map((movie) => Movie.fromMap(movie))
          .where((movie) => !movie.adult)
          .toList();
      print(movies);
      return movies;
    } else {
      throw Exception('Failed to load');
    }
  }

  //for the upcoming movies
  Future<List<Movie>> getUpcoming() async {
    Uri url = Uri.parse(upComingApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data
          .map((movie) => Movie.fromMap(movie))
          .where((movie) => !movie.adult)
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load');
    }
  }

  //for the popular movies
  Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data
          .map((movie) => Movie.fromMap(movie))
          .where((movie) => !movie.adult)
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Movie>> getTopRated() async {
    Uri url = Uri.parse(topRatedApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data
          .map((movie) => Movie.fromMap(movie))
          .where((movie) => !movie.adult)
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Movie>> getLatestTvSeries() async {
    Uri url = Uri.parse(latestTvSeriesApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data
          .map((movie) => Movie.fromMap(movie))
          .where((movie) => !movie.adult)
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Movie>> getMoviesForSlider(int page) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$api_key&page=$page");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data
          .map((movie) => Movie.fromMap(movie))
          .where(
              (movie) => !movie.adult) // Filter out movies with adult content
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

class movies {
  final String title;
  final bool adult;

  movies({required this.title, required this.adult});

  factory movies.fromMap(Map<String, dynamic> map) {
    return movies(
      title: map['title'] ?? 'Untitled',
      adult: map['adult'] ?? false, // Ensure this field exists
    );
  }
}
