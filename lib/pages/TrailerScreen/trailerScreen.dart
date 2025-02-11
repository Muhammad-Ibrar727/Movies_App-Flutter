import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerScreen extends StatefulWidget {
  int MovieId;
  final String type;
  MovieTrailerScreen({super.key, required this.MovieId, required this.type});

  @override
  _MovieTrailerScreenState createState() => _MovieTrailerScreenState();
}

class _MovieTrailerScreenState extends State<MovieTrailerScreen> {
  YoutubePlayerController? _controller;
  bool isLoading = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchTrailer(widget.MovieId, widget.type);
  }

  Future<void> fetchTrailer(int movieId, String type) async {
    const String apiKey = "Enter your api key";
    final url = Uri.parse(
        'https://api.themoviedb.org/3/$type/$movieId/videos?api_key=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];

        // Look for a "Trailer" type video on YouTube
        final trailer = results.firstWhere(
          (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
          orElse: () => null,
        );

        if (trailer != null) {
          final youtubeKey = trailer['key'];
          _controller = YoutubePlayerController(
            initialVideoId: youtubeKey,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          );
        } else {
          hasError = true; // No trailer found
        }
      } else {
        hasError = true; // API returned an error
      }
    } catch (e) {
      hasError = true;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
        title: const Text("Trailer"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : hasError || _controller == null
                  ? const Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                    ),
        ),
      ),
    );
  }
}
