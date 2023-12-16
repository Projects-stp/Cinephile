import 'package:cinephile/presentation/journeys/home/movie_tabbed/movie_tab_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/movie_entity.dart';

class MovieListViewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieListViewBuilder({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 14);
      },
      itemBuilder: (context, index) {
        final MovieEntity movie = movies[index];
        return MovieTabCardWidget(
          movieId: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
        );
      },
      itemCount: movies.length,
    );
  }
}
