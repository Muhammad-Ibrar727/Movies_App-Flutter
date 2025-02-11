import 'package:flutter/material.dart';

class Favoritemovies extends StatefulWidget {
  const Favoritemovies({super.key});

  @override
  State<Favoritemovies> createState() => _FavoritemoviesState();
}

class _FavoritemoviesState extends State<Favoritemovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        
      ),
    );
  }
}
