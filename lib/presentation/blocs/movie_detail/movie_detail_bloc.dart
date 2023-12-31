import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/movie_detail_entity.dart';
import 'package:cinephile/domain/entities/movie_params.dart';
import 'package:cinephile/presentation/blocs/cast/cast_event.dart';
import 'package:cinephile/presentation/blocs/favorite/favotitr.event.dart';
import 'package:cinephile/presentation/blocs/loading/loading_event.dart';
import 'package:cinephile/presentation/blocs/movie_detail/movie_detail_event.dart';
import 'package:cinephile/presentation/blocs/movie_detail/movie_detail_state.dart';
import 'package:cinephile/presentation/blocs/videos/videos_event.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_movie_details.dart';
import '../cast/cast_bloc.dart';
import '../favorite/favotite_bloc.dart';
import '../loading/loading_bloc.dart';
import '../videos/videos_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideosBloc videosBloc;
  final FavoriteBloc favoriteBloc;
  final LoadingBloc loadingBloc;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.castBloc,
    required this.videosBloc,
    required this.favoriteBloc,
    required this.loadingBloc,
  }) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is MovieDetailLoadEvent) {
      loadingBloc.add(StartLoading());
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

      favoriteBloc.add(CheckIfFavouriteMovieEvent(event.movieId));

      castBloc.add(LoadCastEvent(movieId: event.movieId));

      videosBloc.add(LoadVideosEvent(event.movieId));

      loadingBloc.add(FinishLoading());
    }
  }
}
