const List genreData = [
  {"id": 28, "name": "Action"},
  {"id": 12, "name": "Adventure"},
  {"id": 16, "name": "Animation"},
  {"id": 35, "name": "Comedy"},
  {"id": 80, "name": "Crime"},
  {"id": 99, "name": "Documentary"},
  {"id": 18, "name": "Drama"},
  {"id": 10751, "name": "Family"},
  {"id": 14, "name": "Fantasy"},
  {"id": 36, "name": "History"},
  {"id": 27, "name": "Horror"},
  {"id": 10402, "name": "Music"},
  {"id": 9648, "name": "Mystery"},
  {"id": 10749, "name": "Romance"},
  {"id": 878, "name": "Science Fiction"},
  {"id": 10770, "name": "TV Movie"},
  {"id": 53, "name": "Thriller"},
  {"id": 10752, "name": "War"},
  {"id": 37, "name": "Western"},
];

class Movie {
  final int id;
  final String overview;
  final String title;
  final String backdropPath;
  final String posterPath;
  final String date;
  final List<String> genreList;
  final double voteAverage;

  const Movie({
    required this.id,
    required this.overview,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.date,
    required this.genreList,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> getGenreNames(List<int> genreIds) {
      return genreIds.map((id) {
        final genre = genreData.firstWhere((element) => element['id'] == id);
        return genre['name'].toString();
      }).toList();
    }

    return Movie(
      id: json['id'] as int,
      overview: json['overview'] as String,
      title: json['title'] as String,
      backdropPath: json['backdrop_path'] == null
          ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaoWQgKOMl7F3QBdHdry4Q9Uw-r5Hnzq2TzA&s"
          : "https://image.tmdb.org/t/p/w500/${json['backdrop_path']}",
      posterPath: json['poster_path'] == null
          ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaoWQgKOMl7F3QBdHdry4Q9Uw-r5Hnzq2TzA&s"
          : "https://image.tmdb.org/t/p/w500/${json['poster_path']}",
      date: json['release_date'] as String,
      genreList: getGenreNames(json['genre_ids'].cast<int>()),
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
