import 'package:cinephile/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/no_params.dart';
import '../repositories/app_repository.dart';

class GetPreferredLanguage extends UseCase<String, NoParams> {
  final AppRepository appRepository;

  GetPreferredLanguage(this.appRepository);

  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await appRepository.getPreferredLanguage();
  }
}
