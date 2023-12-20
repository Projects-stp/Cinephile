import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/cast_entity.dart';
import 'package:cinephile/domain/entities/movie_params.dart';
import 'package:cinephile/presentation/blocs/cast/cast_event.dart';
import 'package:cinephile/presentation/blocs/cast/cast_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_cast.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getCast;

  CastBloc({
    required this.getCast,
  }) : super(CastInitial());

  @override
  Stream<CastState> mapEventToState(
    CastEvent event,
  ) async* {
    if (event is LoadCastEvent) {
      Either<AppError, List<CastEntity>> eitherResponses =
          await getCast(MovieParams(event.movieId));

      yield eitherResponses.fold(
        (l) => CastError(),
        (r) => CastLoaded(casts: r),
      );
    }
  }
}
