class Movie {
  final int id;
  final String overview;
  final String title;
  final String backdropPath;
  final String posterPath;
  final String date;
  final double voteAverage;

  const Movie({
    required this.id,
    required this.overview,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.date,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
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
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
