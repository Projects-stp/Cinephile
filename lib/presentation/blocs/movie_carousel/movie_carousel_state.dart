import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MovieCarouselState extends Equatable {
  const MovieCarouselState();

  @override
  List<Object> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState {}

class MovieCarouselError extends MovieCarouselState {
  final AppErrorType errorType;

  const MovieCarouselError(this.errorType);
}

class MovieCarouselLoaded extends MovieCarouselState {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouselLoaded({
    required this.movies,
    this.defaultIndex = 0,
  }) : assert(defaultIndex >= 0, 'defaultIndex cannot be less that 0');

  @override
  List<Object> get props => [movies, defaultIndex];
}
