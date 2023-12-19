import 'dart:io';

import 'package:cinephile/data/dataSources/movie_remote_data_source.dart';
import 'package:cinephile/data/models/movie_model.dart';
import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/app_error.dart';

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
}
