import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';
// part of 'movie_backdrop_bloc.dart';

abstract class MovieBackDropEvent extends Equatable {
  const MovieBackDropEvent();

  @override
  List<Object> get props => [];
}

class MovieBackDropChangedEvent extends MovieBackDropEvent {
  final MovieEntity movie;

  const MovieBackDropChangedEvent(this.movie);

  @override
  List<Object> get props => [movie];
}
