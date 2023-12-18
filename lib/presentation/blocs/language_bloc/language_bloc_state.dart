import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LanguageBlocState extends Equatable {
  const LanguageBlocState();

  @override
  List<Object> get props => [];
}

class LanguageLoaded extends LanguageBlocState {
  final Locale locale;

  const LanguageLoaded(this.locale);

  @override
  List<Object> get props => [locale.languageCode];
}
