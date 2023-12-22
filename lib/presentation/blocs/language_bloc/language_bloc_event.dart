import 'package:cinephile/domain/entities/language_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LanguageBlocEvent extends Equatable {
  const LanguageBlocEvent();

  @override
  List<Object> get props => [];
}

class ToggleLanguageEvent extends LanguageBlocEvent {
  final LanguageEntity language;

  const ToggleLanguageEvent(this.language);

  @override
  List<Object> get props => [language.code];
}

class LoadPrferredLanguageEvent extends LanguageBlocEvent {}
