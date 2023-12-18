import 'package:cinephile/common/constants/languages.dart';
import 'package:cinephile/common/screenutil/screenutil.dart';
import 'package:cinephile/dependencyInjection/get_it.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_bloc.dart';
import 'package:cinephile/presentation/journeys/home/home_screen.dart';
import 'package:cinephile/presentation/themes/app_color.dart';
import 'package:cinephile/presentation/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization.dart';
import 'blocs/language_bloc/language_bloc_state.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBlocBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBlocBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider<LanguageBlocBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBlocBloc, LanguageBlocState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Movie App',
              theme: ThemeData(
                primaryColor: AppColor.vulcan,
                scaffoldBackgroundColor: AppColor.vulcan,
                unselectedWidgetColor: AppColor.royalBlue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: ThemeText.getTextTheme(),
                appBarTheme: const AppBarTheme(elevation: 0.0),
              ),
              supportedLocales:
                  Languages.languages.map((e) => Locale(e.code)).toList(),
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const HomeScreen(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
