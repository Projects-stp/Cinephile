import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_backdrop_event.dart';
import 'movie_backdrop_state.dart';

class MovieBackDropBloc extends Bloc<MovieBackDropEvent, MovieBackDropState> {
  MovieBackDropBloc() : super(MovieBackDropInitial());

  @override
  Stream<MovieBackDropState> mapEventToState(
    MovieBackDropEvent event,
  ) async* {
    yield MovieBackDropChanged((event as MovieBackDropChangedEvent).movie);
  }
}
