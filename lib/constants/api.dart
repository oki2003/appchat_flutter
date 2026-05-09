class Api {
  static const String baseURL = "http://192.168.1.97:3000";
  static const String baseSocketURL = "http://192.168.1.97:3000";

  // account
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String auth = "/auth/auth";

  // chats and friends
  // static const String friendships = "/api/FriendShips";

  // movie
  static const String movies = "/movie";

  // messages
  static String messages(int idChat) => "/message/$idChat";
  static String moreMessages(int idChat, int id, DateTime createdAt) =>
      "/message/$idChat?cursorId=$id&cursorCreatedAt=${createdAt.toIso8601String()}";

  // chats
  static const String chats = "/chat";
}
