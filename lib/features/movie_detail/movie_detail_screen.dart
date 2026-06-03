import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/movie_detail/cubit/movie_detail_cubit.dart';
import 'package:appchat_flutter/models/actor.dart';
import 'package:appchat_flutter/models/author_detail.dart';
import 'package:appchat_flutter/models/comment.dart';
import 'package:appchat_flutter/models/movie.dart';
import 'package:appchat_flutter/widgets/error_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Image.network(movie.backdropPath),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: SizedBox(
                    width: screenWidth / 3,
                    child: FractionalTranslation(
                      translation: Offset(0.0, 0.4),
                      child: ClipRRect(
                        borderRadius: const BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                        child: Image.network(movie.posterPath),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: screenWidth / 3 + 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              movie.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.star_rounded, size: 17),
                                Text(
                                  movie.date,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                _buildDot(),
                                Text(
                                  movie.date.split("-")[0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                _buildDot(),
                                Icon(Icons.timer_outlined, size: 17),
                                Text(
                                  "2h 8min",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...movie.genreList.map(
                          (genre) => Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xfff1f5f9),
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      "Tổng quan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    movie.overview,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => BlocProvider.value(
                          value: context.read<MovieDetailCubit>(),
                          child: _buildCommentList(screenHeight),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      "Xem bình luận",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<MovieDetailCubit>(),
                          child: _buildActorList(screenHeight),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      "Xem diễn viên",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      width: 4,
      height: 4,
    );
  }

  Widget _buildCommentList(double screenHeight) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state.status == StatusType.loading) {
          return _buildSkeletonComments();
        }
        if (state.status == StatusType.error) {
          return ErrorWidgetCustom(
            message: state.msg ?? "",
            onRefresh: () =>
                context.read<MovieDetailCubit>().fetchComments(movie.id),
          );
        }
        return DraggableScrollableSheet(
          initialChildSize: 1.0,
          minChildSize: 0.1,
          maxChildSize: 1.0,
          expand: false,
          snap: true,
          snapSizes: [1.0],
          builder: (context, scrollController) => Container(
            height: screenHeight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.comments.length,
              itemBuilder: (context, index) =>
                  _buildCommentItem(state.comments[index]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommentItem(Comment comment) {
    final AuthorDetails author = comment.authorDetails;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: author.avatarPath != null
                ? NetworkImage(author.avatarPath!)
                : null,
            child: author.avatarPath == null
                ? Text(
                    author.name.isNotEmpty ? author.name[0].toUpperCase() : "?",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : null,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        author.name.isNotEmpty ? author.name : "Ẩn danh",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "@${author.username}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment.content, style: const TextStyle(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActorList(double screenHeight) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state.status == StatusType.loading) {
          return _buildSkeletonActors(screenHeight);
        }
        if (state.status == StatusType.error) {
          return ErrorWidgetCustom(
            message: state.msg ?? "",
            onRefresh: () =>
                context.read<MovieDetailCubit>().fetchActors(movie.id),
          );
        }
        return SizedBox(
          height: screenHeight / 4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.actors.length,
            itemBuilder: (context, index) =>
                _buildActorItem(state.actors[index], screenHeight),
          ),
        );
      },
    );
  }

  Widget _buildActorItem(Actor actor, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: screenHeight / 20,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: actor.profilePath != null
                ? NetworkImage(actor.profilePath!)
                : null,
            child: actor.profilePath == null
                ? Text(
                    actor.name.isNotEmpty ? actor.name[0].toUpperCase() : "?",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(actor.name),
        ],
      ),
    );
  }

  Widget _buildSkeletonComments() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 80, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonActors(double screenHeight) {
    return SizedBox(
      height: screenHeight / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSkeletonActorItem(screenHeight),
          _buildSkeletonActorItem(screenHeight),
          _buildSkeletonActorItem(screenHeight),
        ],
      ),
    );
  }

  Widget _buildSkeletonActorItem(double screenHeight) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenHeight / 10,
              height: screenHeight / 10,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 12,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
