import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class MovieTabbedState extends Equatable {
  final int currentTabIndex;

  const MovieTabbedState({
    this.currentTabIndex = 0,
  });

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabbedInitial extends MovieTabbedState {}

class MovieTabChanges extends MovieTabbedState {
  final List<MovieEntity> movies;

  const MovieTabChanges({
    required int currentTabIndex,
    required this.movies,
  }) : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, movies];
}

class MovieTabLoadError extends MovieTabbedState {
  const MovieTabLoadError({
    required int currentTabIndex,
  }) : super(currentTabIndex: currentTabIndex);
}
