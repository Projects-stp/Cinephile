import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/domain/usecases/get_trending.dart';
import 'package:cinephile/presentation/blocs/loading/loading_event.dart';
import 'package:cinephile/presentation/blocs/movie_backdrop/movie_backdrop_event.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_event.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../loading/loading_bloc.dart';
import '../movie_backdrop/movie_backdrop_bloc.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackDropBloc movieBackDropBloc;
  final LoadingBloc loadingBloc;

  MovieCarouselBloc({
    required this.getTrending,
    required this.movieBackDropBloc,
    required this.loadingBloc,
  }) : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if (event is CarouselLoadEvent) {
      loadingBloc.add(StartLoading());
      final moviesEither = await getTrending(NoParams());
      yield moviesEither.fold(
        (l) => MovieCarouselError(l.appErrorType),
        (movies) {
          movieBackDropBloc
              .add(MovieBackDropChangedEvent(movies[event.defaultIndex]));
          return MovieCarouselLoaded(
            movies: movies,
            defaultIndex: event.defaultIndex,
          );
        },
      );
      loadingBloc.add(FinishLoading());
    }
  }
}
