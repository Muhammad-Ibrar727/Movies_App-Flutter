class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  // Factory method to create a Genre from a Map (API response)
  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map['id'],
      name: map['name'],
    );
  }
}
