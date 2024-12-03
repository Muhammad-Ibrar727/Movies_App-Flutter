class Movie {
  final String title;
  final String backDropPath;
  final String overview;

  Movie(
      {required this.title,
      required this.backDropPath,
      required this.overview});

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      backDropPath: map['backdrop_path'],
      overview: map['overview'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backdrop_path': backDropPath,
      'overview': overview,
    };
  }
}
