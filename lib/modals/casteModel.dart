class Cast {
  final String? profilePath;
  final String name;
  final String knownForDepartment;

  Cast({
    this.profilePath,
    required this.name,
    required this.knownForDepartment,
  });

  // Factory constructor to create a Cast object from a JSON map
  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      profilePath: json['profile_path'],
      name: json['name'] ?? 'Unknown', // Default to 'Unknown' if name is missing
      knownForDepartment: json['known_for_department'] ?? 'Unknown', // Default to 'Unknown'
    );
  }

  // Convert Cast object to JSON map (if needed)
  Map<String, dynamic> toJson() {
    return {
      'profile_path': profilePath,
      'name': name,
      'known_for_department': knownForDepartment,
    };
  }
}
