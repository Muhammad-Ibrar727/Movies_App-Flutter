import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/pages/MovieDetail/detail.dart';

class Searchscreen extends StatefulWidget {
  String type;
  Searchscreen({super.key, required this.type});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController searchcontroller = TextEditingController();
  List result = [];

  Future<dynamic> Searchscreen(String Query, type) async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/$type?api_key=Enter your api key&query=$Query'),
      // 'https://api.themoviedb.org/3/search/multi?api_key=84c27dd064f167db07cb40b110dfcf48&query=$Query'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        result = data['results'];
      });
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
            title: const Text(
              'search movies',
              style: TextStyle(fontSize: 17),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Text(
                'What would you like to watch?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, wordSpacing: 2),
              ),
            )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    controller: searchcontroller,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              if (searchcontroller.text.isNotEmpty) {
                                Searchscreen(
                                    searchcontroller.text, widget.type);
                              }
                            },
                            child: const Icon(Icons.search)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: "search ${widget.type}",
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.2)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.3), width: 1),
                            borderRadius: BorderRadius.circular(100)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.3), width: 1),
                            borderRadius: BorderRadius.circular(100))),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Results ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail(
                                        movieId: movie['id'], type: 'movie')));
                          },
                          child: Row(children: [
                            Container(
                              height: 100,
                              width: 80,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    movie['title'] ?? 'No Title',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                // Text('Movie • 2024'),
                                Text(
                                    "Movie • ${movie['release_date']?.substring(0, 4) ?? 'N/A'}") // it show the year first 4 digits
                              ],
                            )
                          ]),
                        ),
                      );
                    }))
          ],
        ));
  }
}
