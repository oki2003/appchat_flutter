import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/movies/cubit/movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MovieScreen();
  }
}

class _MovieScreen extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state.status != StatusType.loaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadiusGeometry.all(
                    Radius.circular(10),
                  ),
                  child: Image.network(
                    state.movieBanner?.backdropPath ?? "",
                    width: double.infinity,
                    height: screenHeight / 4,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Mới"),
                          Icon(Icons.star_rounded, color: Colors.yellow),
                          Text("${state.movieBanner?.voteAverage}"),
                        ],
                      ),
                      Text(state.movieBanner?.title ?? ""),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
            const Text("Xu hướng"),
            SizedBox(
              height: screenHeight / 3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.trendingMovies.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: screenWidth / 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight / 4,
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadiusGeometry.all(
                                Radius.circular(10),
                              ),
                              child: Image.network(
                                state.trendingMovies[index].posterPath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.broken_image),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            state.trendingMovies[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Text("Tất cả"),

            GridView.builder(
              itemCount: state.allMovies.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 2 / 4,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadiusGeometry.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        state.allMovies[index].posterPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image));
                        },
                      ),
                    ),
                  ),
                  Text(
                    state.allMovies[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
