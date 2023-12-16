import 'package:cinephile/common/constants/size_constants.dart';
import 'package:cinephile/common/extensions/size_extensions.dart';
import 'package:cinephile/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:cinephile/presentation/blocs/movie_tabbed/movie_tabbed_event.dart';
import 'package:cinephile/presentation/blocs/movie_tabbed/movie_tabbed_state.dart';
import 'package:cinephile/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:cinephile/presentation/journeys/home/movie_tabbed/movie_tabbed_constants.dart';
import 'package:cinephile/presentation/journeys/home/movie_tabbed/tab_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieTabbedWidget extends StatefulWidget {
  const MovieTabbedWidget({super.key});

  @override
  State<MovieTabbedWidget> createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedBloc.add(MovieTabChangedEvent(currentTabIndex: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_2.h),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0;
                      i < MovieTabbedConstants.movieTabs.length;
                      i++)
                    TabTitleWidget(
                      title: MovieTabbedConstants.movieTabs[i].title,
                      onTap: () => _onTabTapped(i),
                      isSelected: MovieTabbedConstants.movieTabs[i].index ==
                          state.currentTabIndex,
                    ),
                ],
              ),
              if (state is MovieTabChanges)
                Expanded(
                  child: MovieListViewBuilder(movies: state.movies),
                ),
            ],
          ),
        );
      },
    );
  }

  void _onTabTapped(int index) {
    movieTabbedBloc.add(MovieTabChangedEvent(currentTabIndex: index));
  }
}
