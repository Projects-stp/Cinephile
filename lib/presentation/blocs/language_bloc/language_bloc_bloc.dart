import 'dart:ui';

import 'package:cinephile/common/constants/languages.dart';
import 'package:cinephile/domain/entities/no_params.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_event.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_preferred_language.dart';
import '../../../domain/usecases/update_langiage.dart';

class LanguageBlocBloc extends Bloc<LanguageBlocEvent, LanguageBlocState> {
  final GetPreferredLanguage getPreferredLanguage;
  final UpdateLanguage updateLanguage;

  LanguageBlocBloc({
    required this.getPreferredLanguage,
    required this.updateLanguage,
  }) : super(
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
      await updateLanguage(event.language.code);
      add(LoadPrferredLanguageEvent());
    } else if (event is LoadPrferredLanguageEvent) {
      final response = await getPreferredLanguage(NoParams());
      yield response.fold(
        (l) => LanguageError(),
        (r) => LanguageLoaded(
          Locale(r),
        ),
      );
    }
  }
}
