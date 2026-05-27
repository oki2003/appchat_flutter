class AuthorDetails {
  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;

  AuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    return AuthorDetails(
      name: json['name'],
      username: json['username'],
      avatarPath: json['avatar_path'] == null
          ? null
          : "https://image.tmdb.org/t/p/w500${json['avatar_path']}",
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'avatar_path': avatarPath,
      'rating': rating,
    };
  }
}
