import 'dart:async';

import 'package:cinephile/data/tables/movie_table.dart';
import 'package:cinephile/presentation/movie_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'dependencyInjection/get_it.dart' as getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    ),
  );

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());

  unawaited(getIt.init());

  runApp(const MovieApp());
}
