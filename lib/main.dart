import 'dart:async';

import 'package:cinephile/domain/entities/app_error.dart';
import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/domain/usecases/get_trending.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'dependancyInjection/get_it.dart' as getIt;
import 'domain/entities/movie_entity.dart';

Future<void> main() async {
  unawaited(getIt.init());
  // ApiClient apiClient = ApiClient(Client());
  // MovieRemoteDataSource dataSource = MovieRemoteDataSourceImpl(apiClient);
  // MovieRepository movieRepository = MovieRepositoryImpl(dataSource);
  GetTrending getTrending = getIt.getItInstance<GetTrending>();
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
