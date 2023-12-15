import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class MovieBackDropState extends Equatable {
  const MovieBackDropState();

  @override
  List<Object> get props => [];
}

class MovieBackDropInitial extends MovieBackDropState {}

class MovieBackDropChanged extends MovieBackDropState {
  final MovieEntity movie;

  const MovieBackDropChanged(this.movie);

  @override
  List<Object> get props => [movie];
}
