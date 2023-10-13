import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/domain/repositories/movie_repository.dart';
import 'package:cinephile/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/no_params.dart';

class GetComingSoon extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetComingSoon(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams params) async {
    return await repository.getComingSoon();
  }
}
