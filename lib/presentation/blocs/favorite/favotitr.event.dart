import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class LoadFavoriteMovieEvent extends FavoriteEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class DeleteFavoriteMovieEvent extends FavoriteEvent {
  final int movieId;

  const DeleteFavoriteMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class ToggleFavoriteMovieEvent extends FavoriteEvent {
  final MovieEntity movieEntity;
  final bool isFavorite;

  const ToggleFavoriteMovieEvent(this.movieEntity, this.isFavorite);

  @override
  List<Object> get props => [movieEntity, isFavorite];
}

class CheckIfFavouriteMovieEvent extends FavoriteEvent {
  final int movieId;

  const CheckIfFavouriteMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
