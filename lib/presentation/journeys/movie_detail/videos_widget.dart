import 'package:cinephile/common/constants/route_constants.dart';
import 'package:cinephile/presentation/blocs/videos/videos_bloc.dart';
import 'package:cinephile/presentation/journeys/movie_detail/watch_videos/watch_videos_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/translation_constants.dart';
import '../../blocs/videos/videos_state.dart';
import '../../widgets/button.dart';

class VideosWidget extends StatelessWidget {
  final VideosBloc videoBloc;

  const VideosWidget({
    Key? key,
    required this.videoBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: videoBloc,
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteList.watchTrailer,
                arguments: WatchVideoArguments(videos),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
