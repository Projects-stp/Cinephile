import 'dart:async';

import 'package:cinephile/presentation/movie_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dependencyInjection/get_it.dart' as getIt;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    ),
  );
  unawaited(getIt.init());

  runApp(const MovieApp());
}
