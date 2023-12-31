import 'package:cinephile/common/constants/languages.dart';
import 'package:cinephile/common/constants/route_constants.dart';
import 'package:cinephile/common/screenutil/screenutil.dart';
import 'package:cinephile/dependencyInjection/get_it.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_bloc.dart';
import 'package:cinephile/presentation/blocs/language_bloc/language_bloc_event.dart';
import 'package:cinephile/presentation/blocs/loading/loading_bloc.dart';
import 'package:cinephile/presentation/journeys/loading_screen/loading_screen.dart';
import 'package:cinephile/presentation/routes.dart';
import 'package:cinephile/presentation/themes/app_color.dart';
import 'package:cinephile/presentation/themes/theme_text.dart';
import 'package:cinephile/presentation/wiredash_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization.dart';
import 'blocs/language_bloc/language_bloc_state.dart';
import 'fade_page_route_builder.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBlocBloc _languageBloc;
  final _navigatorKey = GlobalKey<NavigatorState>();
  late LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBlocBloc>();
    _languageBloc.add(LoadPrferredLanguageEvent());
    _loadingBloc = getItInstance<LoadingBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loadingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBlocBloc>.value(value: _languageBloc),
        BlocProvider<LoadingBloc>.value(value: _loadingBloc),
      ],
      child: BlocBuilder<LanguageBlocBloc, LanguageBlocState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return WiredashApp(
              navigatorKey: _navigatorKey,
              child: MaterialApp(
                navigatorKey: _navigatorKey,
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
                builder: (context, child) {
                  return LoadingScreen(screen: child!);
                },
                initialRoute: RouteList.initial,
                onGenerateRoute: (RouteSettings settings) {
                  final routes = Routes.getRoutes(settings);
                  final WidgetBuilder? builder = routes[settings.name];
                  return FadePageRouteBuilder(
                    builder: builder!,
                    settings: settings,
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
