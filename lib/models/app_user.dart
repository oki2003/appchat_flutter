class AppUser {
  final int id;
  final String email;
  final String name;
  final String? avatarURL;
  final String? backgroundURL;

  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarURL,
    required this.backgroundURL,
  });

  factory AppUser.fromJSON(Map<String, dynamic> json) => AppUser(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    avatarURL: json["avatarURL"],
    backgroundURL: json["backgroundURL"],
  );
}
