import 'dart:io';

import 'package:cinephile/data/dataSources/movie_remote_data_source.dart';
import 'package:cinephile/data/models/movie_detail_model.dart';
import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/domain/entities/video_entity.dart';
import 'package:cinephile/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/app_error.dart';
import '../models/cast_crew_result_data_model.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return Right(movies);
    } on SocketException {
      return const Left(
        AppError(AppErrorType.network),
      );
    } on Exception {
      return const Left(
        AppError(AppErrorType.api),
      );
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try {
      final movies = await remoteDataSource.getComingSoon();
      return Right(movies);
    } on SocketException {
      return const Left(
        AppError(AppErrorType.network),
      );
    } on Exception {
      return const Left(
        AppError(AppErrorType.api),
      );
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    } on SocketException {
      return const Left(
        AppError(AppErrorType.network),
      );
    } on Exception {
      return const Left(
        AppError(AppErrorType.api),
      );
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      return Right(movies);
    } on SocketException {
      return const Left(
        AppError(AppErrorType.network),
      );
    } on Exception {
      return const Left(
        AppError(AppErrorType.api),
      );
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
    try {
      final castCrew = await remoteDataSource.getCastCrew(id);
      return Right(castCrew);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VideoEntity>>> getVideos(int id) async {
    try {
      final videos = await remoteDataSource.getVideos(id);
      return Right(videos);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
