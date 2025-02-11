import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/modals/casteModel.dart';

class ApiService {
  // Replace with actual API URL
  final String api_Key =
      'Enter your api key'; 

  Future<List<Cast>> fetchCast(int movieId, String type) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/$type/$movieId/credits?api_key=$api_Key');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List castJson = data['cast']; // Extract the 'cast' array
        return castJson.map((json) => Cast.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cast');
      }
    } catch (e) {
      return [];
    }
  }
}
