import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/movie_detail_entity.dart';
import 'package:cinephile/domain/entities/movie_params.dart';
import 'package:cinephile/presentation/blocs/movie_detail/movie_detail_event.dart';
import 'package:cinephile/presentation/blocs/movie_detail/movie_detail_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_movie_details.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is MovieDetailLoadEvent) {
      final Either<AppError, MovieDetailEntity> eitherResponse =
          await getMovieDetail(
        MovieParams(
          event.movieId,
        ),
      );
      yield eitherResponse.fold(
        (l) => MovieDetailError(),
        (r) => MovieDetailLoaded(r),
      );
    }
  }
}
