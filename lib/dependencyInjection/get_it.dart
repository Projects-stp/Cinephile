import 'package:cinephile/data/core/api_client.dart';
import 'package:cinephile/data/repositories/movie_repository_impl.dart';
import 'package:cinephile/domain/repositories/movie_repository.dart';
import 'package:cinephile/domain/usecases/get_cast.dart';
import 'package:cinephile/domain/usecases/get_movie_details.dart';
import 'package:cinephile/domain/usecases/get_videos.dart';
import 'package:cinephile/presentation/blocs/cast/cast_bloc.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_bloc.dart';
import 'package:cinephile/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:cinephile/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:cinephile/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:cinephile/presentation/blocs/search_movies/search_movies_bloc.dart';
import 'package:cinephile/presentation/blocs/videos/videos_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../data/dataSources/movie_remote_data_source.dart';
import '../domain/usecases/get_coming_soon.dart';
import '../domain/usecases/get_playing_now.dart';
import '../domain/usecases/get_popular.dart';
import '../domain/usecases/get_trending.dart';
import '../domain/usecases/search_movies.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));

  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));

  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));

  getItInstance.registerFactory(() => MovieBackDropBloc());

  getItInstance.registerFactory(() => MovieCarouselBloc(
      getTrending: getItInstance(), movieBackDropBloc: getItInstance()));

  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      GetPopular(getItInstance()),
      GetPlayingNow(getItInstance()),
      GetComingSoon(getItInstance()),
    ),
  );

  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => CastBloc(
      getCast: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      searchMovies: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageBlocBloc>(LanguageBlocBloc());
}
