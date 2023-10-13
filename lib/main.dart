import 'package:cinephile/data/core/api_client.dart';
import 'package:cinephile/data/dataSources/movie_remote_data_source.dart';
import 'package:cinephile/data/repositories/movie_repository_impl.dart';
import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/domain/repositories/movie_repository.dart';
import 'package:cinephile/domain/usecases/get_trending.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'domain/entities/movie_entity.dart';

void main() async {
  ApiClient apiClient = ApiClient(Client());
  MovieRemoteDataSource dataSource = MovieRemoteDataSourceImpl(apiClient);
  MovieRepository movieRepository = MovieRepositoryImpl(dataSource);
  GetTrending getTrending = GetTrending(movieRepository);
  final Either<AppError, List<MovieEntity>> eitherResponse =
      await getTrending(NoParams());

  eitherResponse.fold(
    (l) {
      print('error');
      print(l);
    },
    (r) {
      print('List of movies');
      print(r);
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(),
    );
  }
}
