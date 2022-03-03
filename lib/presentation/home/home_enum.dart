import 'package:movieapp/app/constant.dart';
import 'package:movieapp/presentation/common/state_appbar/state_appbar_impl.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

enum HomeSections {
  FOREIGN_MOVIES,
  TRENDING,
  NEW_MOVIES,
  INDIAN_MOVIES,
  ARABIC_MOVIES,
}

extension HomeDataExtension on HomeSections {
  MovieListArgs getMovieListArgs({AppBarState? appBarState}) {
    switch (this) {
      case HomeSections.FOREIGN_MOVIES:
        return MovieListArgs(Endpoints.foreign, AppStrings.foreignMovies.tr(),appBarState:appBarState);
      case HomeSections.TRENDING:
        return MovieListArgs(Endpoints.trending, AppStrings.trending.tr(),appBarState:appBarState);
      case HomeSections.NEW_MOVIES:
        return MovieListArgs(Endpoints.neW, AppStrings.newMovies.tr(),appBarState:appBarState);
      case HomeSections.INDIAN_MOVIES:
        return MovieListArgs(Endpoints.indian, AppStrings.indianMovies.tr(),appBarState:appBarState);
      case HomeSections.ARABIC_MOVIES:
        return MovieListArgs(Endpoints.arabic, AppStrings.arabicMovies.tr(),appBarState:appBarState);
    }
  }
}