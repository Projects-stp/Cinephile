import 'dart:ui';

import 'package:cinephile/common/constants/languages.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_event.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBlocBloc extends Bloc<LanguageBlocEvent, LanguageBlocState> {
  LanguageBlocBloc()
      : super(
          LanguageLoaded(
            Locale(
              Languages.languages[0].code,
            ),
          ),
        );

  @override
  Stream<LanguageBlocState> mapEventToState(
    LanguageBlocEvent event,
  ) async* {
    if (event is ToggleLanguageEvent) {
      yield LanguageLoaded(Locale(event.language.code));
    }
  }
}
