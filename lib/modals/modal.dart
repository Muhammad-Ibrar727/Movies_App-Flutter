class Movie {
  final String title;
  final String backDropPath;
  final String overview;
  final int id;
  List<int> genre_ids;
  String poster_path;
  final bool adult;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.genre_ids,
    required this.poster_path,
    required this.id,
    required this.adult,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      backDropPath: map['backdrop_path'],
      overview: map['overview'],
      poster_path: map['poster_path'],
      genre_ids: List<int>.from(map['genre_ids']),
      id: map['id'],
      adult: map['adult'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backdrop_path': backDropPath,
      'overview': overview,
      'genre_ids': genre_ids,
      'poster_path': poster_path,
      'id': id,
      'adult': adult,
    };
  }
}
