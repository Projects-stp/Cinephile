import 'package:cinephile/common/constants/translation_constants.dart';
import 'package:cinephile/presentation/journeys/home/movie_tabbed/tab.dart';

class MovieTabbedConstants {
  static const List<Tab> movieTabs = [
    Tab(title: TranslationConstants.popular, index: 0),
    Tab(title: TranslationConstants.now, index: 1),
    Tab(title: TranslationConstants.soon, index: 2),
  ];
}
