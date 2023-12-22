import 'package:cinephile/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_params.dart';
import '../repositories/movie_repository.dart';

class DeleteFavoriteMovie extends UseCase<void, MovieParams> {
  final MovieRepository movieRepository;

  DeleteFavoriteMovie(this.movieRepository);

  @override
  Future<Either<AppError, void>> call(MovieParams movieParams) async {
    return await movieRepository.deleteFavoriteMovie(movieParams.id);
  }
}
