import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/movie/cubit/movie_cubit.dart';
import 'package:appchat_flutter/features/movie_detail/cubit/movie_detail_cubit.dart';
import 'package:appchat_flutter/features/movie_detail/movie_detail_screen.dart';
import 'package:appchat_flutter/models/movie.dart';
import 'package:appchat_flutter/theme/brand_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final BrandAppTheme brandAppTheme = BrandAppTheme(context: context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state.status != StatusType.loaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(state.movies.first, screenHeight),
              Text(
                "Tất cả",
                style: TextStyle(height: 4, color: brandAppTheme.textColor),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) => _buildMovie(
                    state.movies[index],
                    screenHeight,
                    context,
                    brandAppTheme,
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBanner(Movie movie, double screenHeight) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadiusGeometry.all(Radius.circular(10)),
          child: Image.network(
            movie.backdropPath,
            width: double.infinity,
            height: screenHeight / 4,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "NỔI BẬT",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                movie.title,
                style: const TextStyle(color: Colors.white, fontSize: 21),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                  Text(movie.date, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMovie(
    Movie movie,
    double screenHeight,
    BuildContext context,
    BrandAppTheme brandAppTheme,
  ) {
    final heightItem = screenHeight / 7;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => MovieDetailCubit()
              ..fetchComments(movie.id)
              ..fetchActors(movie.id),
            child: MovieDetailScreen(movie: movie),
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.all(Radius.circular(10)),
            child: Image.network(
              movie.posterPath,
              height: heightItem,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: heightItem,
            child: Padding(
              padding: const EdgeInsetsGeometry.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: brandAppTheme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: brandAppTheme.noteBrandColor,
                        size: 17,
                      ),
                      Text(
                        movie.date,
                        style: TextStyle(
                          color: brandAppTheme.noteBrandColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ...movie.genreList
                          .map(
                            (genre) => Container(
                              margin: EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: brandAppTheme.containerColor,
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Text(
                                genre,
                                style: TextStyle(
                                  color: brandAppTheme.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                          .take(2),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: brandAppTheme.textColor,
                        size: 17,
                      ),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: TextStyle(
                          color: brandAppTheme.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
