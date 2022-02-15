import 'package:movieapp/app/constant.dart';
import 'package:movieapp/presentation/common/state_appbar/state_appbar_impl.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';

enum HomeSections {
  TOP_MOVIES,
  TRENDING,
  NEW_MOVIES,
  INDIAN_MOVIES,
  ARABIC_MOVIES,
}

extension HomeDataExtension on HomeSections {
  MovieListArgs getMovieListArgs({AppBarState? appBarState}) {
    switch (this) {
      case HomeSections.TOP_MOVIES:
        return MovieListArgs(Endpoints.top, AppStrings.topMovies,appBarState:appBarState);
      case HomeSections.TRENDING:
        return MovieListArgs(Endpoints.trending, AppStrings.trending,appBarState:appBarState);
      case HomeSections.NEW_MOVIES:
        return MovieListArgs(Endpoints.neW, AppStrings.newMovies,appBarState:appBarState);
      case HomeSections.INDIAN_MOVIES:
        return MovieListArgs(Endpoints.indian, AppStrings.indianMovies,appBarState:appBarState);
      case HomeSections.ARABIC_MOVIES:
        return MovieListArgs(Endpoints.arabic, AppStrings.arabicMovies,appBarState:appBarState);
    }
  }
}