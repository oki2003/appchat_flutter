class AppUser {
  final int id;
  final String displayName;
  final String userName;
  final String? avatarUrl;

  const AppUser({
    required this.id,
    required this.displayName,
    required this.userName,
    required this.avatarUrl,
  });

  factory AppUser.fromJSON(Map<String, dynamic> json) => AppUser(
    id: json["id"],
    displayName: json["displayName"],
    userName: json["userName"],
    avatarUrl: json["avatarUrl"],
  );
}
