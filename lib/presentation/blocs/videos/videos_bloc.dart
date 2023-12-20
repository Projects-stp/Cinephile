import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/movie_params.dart';
import 'package:cinephile/domain/entities/video_entity.dart';
import 'package:cinephile/presentation/blocs/videos/videos_event.dart';
import 'package:cinephile/presentation/blocs/videos/videos_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_videos.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;

  VideosBloc({
    required this.getVideos,
  }) : super(VideosInitial());

  @override
  Stream<VideosState> mapEventToState(
    VideosEvent event,
  ) async* {
    if (event is LoadVideosEvent) {
      final Either<AppError, List<VideoEntity>> eitherResponse =
          await getVideos(
        MovieParams(
          event.movieId,
        ),
      );

      yield eitherResponse.fold(
        (l) => NoVideos(),
        (r) => VideosLoaded(r),
      );
    }
  }
}
