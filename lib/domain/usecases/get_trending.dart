import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/domain/repositories/movie_repository.dart';
import 'package:cinephile/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';

class GetTrending extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetTrending(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams params) async {
    return await repository.getTrending();
  }
}
