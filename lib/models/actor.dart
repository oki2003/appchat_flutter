class Actor {
  final int id;
  final String name;
  final String? profilePath;

  Actor({required this.id, required this.name, this.profilePath});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] == null
          ? null
          : "https://image.tmdb.org/t/p/w500${json['profile_path']}",
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'profilePath': profilePath};
  }
}
