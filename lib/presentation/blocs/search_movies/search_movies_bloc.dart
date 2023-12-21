import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/domain/entities/movie_search_params.dart';
import 'package:cinephile/presentation/blocs/search_movies/search_movies_event.dart';
import 'package:cinephile/presentation/blocs/search_movies/search_movies_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/search_movies.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieBloc({
    required this.searchMovies,
  }) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    if (event is SearchTermChangedEvent) {
      if (event.searchTerm.isNotEmpty) {
        yield SearchMovieLoading();
        final Either<AppError, List<MovieEntity>> response = await searchMovies(
          MovieSearchParams(
            searchTerm: event.searchTerm,
          ),
        );
        yield response.fold(
          (l) => SearchMovieError(l.appErrorType),
          (r) => SearchMovieLoaded(r),
        );
      }
    }
  }
}
