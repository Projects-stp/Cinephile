import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/domain/entities/movie_params.dart';
import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/domain/usecases/get_favoutites_movies.dart';
import 'package:cinephile/presentation/blocs/favorite/favotite_state.dart';
import 'package:cinephile/presentation/blocs/favorite/favotitr.event.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_if_movie_favorite.dart';
import '../../../domain/usecases/delete_favourite_movies.dart';
import '../../../domain/usecases/save_movie.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovies;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavouriteMovie;

  FavoriteBloc({
    required this.checkIfFavouriteMovie,
    required this.deleteFavoriteMovie,
    required this.getFavoriteMovies,
    required this.saveMovies,
  }) : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(event.movieEntity.id));
      } else {
        await saveMovies(event.movieEntity);
      }
      final response =
          await checkIfFavouriteMovie(MovieParams(event.movieEntity.id));
      yield response.fold(
        (l) => FavouriteMoviesError(),
        (r) => IsFavoriteMovie(r),
      );
    } else if (event is LoadFavoriteMovieEvent) {
      yield* _fetchLoadFavoriteMovies();
    } else if (event is DeleteFavoriteMovieEvent) {
      await deleteFavoriteMovie(MovieParams(event.movieId));
      yield* _fetchLoadFavoriteMovies();
    } else if (event is CheckIfFavouriteMovieEvent) {
      final response = await checkIfFavouriteMovie(MovieParams(event.movieId));
      yield response.fold(
        (l) => FavouriteMoviesError(),
        (r) => IsFavoriteMovie(r),
      );
    }
  }

  Stream<FavoriteState> _fetchLoadFavoriteMovies() async* {
    final Either<AppError, List<MovieEntity>> response =
        await getFavoriteMovies(NoParams());

    yield response.fold(
      (l) => FavouriteMoviesError(),
      (r) => FavoriteMoviesLoaded(r),
    );
  }
}
