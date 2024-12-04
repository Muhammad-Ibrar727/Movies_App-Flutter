import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/modals/Genres_model.dart';

const api_key = "84c27dd064f167db07cb40b110dfcf48";

class GenreServices {
  final String genreEndpoint =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$api_key&language=en-US';

  Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse(genreEndpoint));
    //for checking the data from the api
    // print('API Response (Genres): ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['genres'];
      return data.map((genreMap) => Genre.fromMap(genreMap)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }
}
