import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/presentation/blocs/movie_tabbed/movie_tabbed_event.dart';
import 'package:cinephile/presentation/blocs/movie_tabbed/movie_tabbed_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_coming_soon.dart';
import '../../../domain/usecases/get_playing_now.dart';
import '../../../domain/usecases/get_popular.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabbedBloc(
    this.getPopular,
    this.getPlayingNow,
    this.getComingSoon,
  ) : super(MovieTabbedInitial());

  @override
  Stream<MovieTabbedState> mapEventToState(
    MovieTabbedEvent event,
  ) async* {
    if (event is MovieTabChangedEvent) {
      late Either<AppError, List<MovieEntity>> movieEither;
      switch (event.currentTabIndex) {
        case 0:
          movieEither = await getPopular(NoParams());
          break;
        case 1:
          movieEither = await getPlayingNow(NoParams());
          break;
        case 2:
          movieEither = await getComingSoon(NoParams());
          break;
      }
      yield movieEither.fold(
        (l) => MovieTabLoadError(currentTabIndex: event.currentTabIndex),
        (movies) {
          return MovieTabChanges(
              currentTabIndex: event.currentTabIndex, movies: movies);
        },
      );
    }
  }
}
