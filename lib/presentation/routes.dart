import 'package:flutter/material.dart';

import '../common/constants/route_constants.dart';
import 'journeys/favorite_screen/favorite_screen.dart';
import 'journeys/home/home_screen.dart';
import 'journeys/movie_detail/movie_detail_arguments.dart';
import 'journeys/movie_detail/movie_detail_screen.dart';
import 'journeys/movie_detail/watch_videos/watch_video_screen.dart';
import 'journeys/movie_detail/watch_videos/watch_videos_argument.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const HomeScreen(),
        RouteList.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: setting.arguments as MovieDetailArguments,
            ),
        RouteList.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments: setting.arguments as WatchVideoArguments,
            ),
        RouteList.favorite: (context) => const FavoriteScreen(),
      };
}
