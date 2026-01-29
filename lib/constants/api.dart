class Api {
  static const String baseURL = "http://192.168.1.3:3000";

  // account
  static const String login = "/api/signIn";
  static const String register = "/api/signUp";
  static const String auth = "/api/auth";

  // chats and friends
  static const String friendships = "/api/FriendShips";

  // movie
  static String movies(String apiKey) =>
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";

  // messages
  static String messages(String idChat) => "/api/getMessage/$idChat";
}
