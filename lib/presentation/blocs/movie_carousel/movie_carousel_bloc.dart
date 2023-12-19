import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/domain/usecases/get_trending.dart';
import 'package:cinephile/presentation/blocs/movie_backdrop/movie_backdrop_event.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_event.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie_backdrop/movie_backdrop_bloc.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackDropBloc movieBackDropBloc;

  MovieCarouselBloc({
    required this.getTrending,
        required this.movieBackDropBloc,
      }) : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if (event is CarouselLoadEvent) {
      final moviesEither = await getTrending(NoParams());
      yield moviesEither.fold(
        (l) => MovieCarouselError(l.appErrorType),
        (movies) {
          movieBackDropBloc.add(MovieBackDropChangedEvent(movies[event.defaultIndex]));
          return MovieCarouselLoaded(
            movies: movies,
            defaultIndex: event.defaultIndex,
          );
        },
      );
    }
  }
}
