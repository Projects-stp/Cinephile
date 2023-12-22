import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteMoviesLoaded extends FavoriteState {
  final List<MovieEntity> movies;

  const FavoriteMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FavouriteMoviesError extends FavoriteState {}

class IsFavoriteMovie extends FavoriteState {
  final bool isMovieFavorite;

  const IsFavoriteMovie(this.isMovieFavorite);

  @override
  List<Object> get props => [isMovieFavorite];
}
