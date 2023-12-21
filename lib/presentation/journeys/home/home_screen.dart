import 'package:cinephile/dependencyInjection/get_it.dart';
import 'package:cinephile/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_event.dart';
import 'package:cinephile/presentation/blocs/movie_carousel/movie_carousel_state.dart';
import 'package:cinephile/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:cinephile/presentation/blocs/search_movies/search_movies_bloc.dart';
import 'package:cinephile/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:cinephile/presentation/journeys/home/movie_tabbed/movie_tabbed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_error_widget.dart';
import 'movie_carousel/movie_carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselBloc movieCarouselBloc;
  late MovieBackDropBloc movieBackDropBloc;
  late MovieTabbedBloc movieTabbedBloc;
  late SearchMovieBloc searchMovieBloc;

  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieBackDropBloc = movieCarouselBloc.movieBackDropBloc;
    movieTabbedBloc = getItInstance<MovieTabbedBloc>();
    searchMovieBloc = getItInstance<SearchMovieBloc>();
    movieCarouselBloc.add(const CarouselLoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc.close();
    movieBackDropBloc.close();
    movieTabbedBloc.close();
    searchMovieBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselBloc,
        ),
        BlocProvider(
          create: (context) => movieBackDropBloc,
        ),
        BlocProvider(
          create: (context) => movieTabbedBloc,
        ),
        BlocProvider(
          create: (context) => searchMovieBloc,
        ),
      ],
      child: Scaffold(
        drawer: const NavigationDrawerH(),
        body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          bloc: movieCarouselBloc,
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.65,
                    child: MovieCarouselWidget(
                      movies: state.movies,
                      defaultIndex: state.defaultIndex,
                    ),
                  ),
                  const FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.35,
                    child: MovieTabbedWidget(),
                  ),
                ],
              );
            } else if (state is MovieCarouselError) {
              return AppErrorWidget(
                onPressed: () => movieCarouselBloc.add(
                  const CarouselLoadEvent(),
                ),
                errorType: state.errorType,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
