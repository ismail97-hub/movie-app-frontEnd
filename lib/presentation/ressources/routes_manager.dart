import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/common/state_appbar/state_appbar_impl.dart';
import 'package:movieapp/presentation/favorites/favorites.dart';
import 'package:movieapp/presentation/history/history_view.dart';
import 'package:movieapp/presentation/home/home.dart';
import 'package:movieapp/presentation/movie_details/movie_details.dart';
import 'package:movieapp/presentation/movie_list/movie_list.dart';
import 'package:movieapp/presentation/movie_player/movie_player.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/settings/settings_view.dart';
import 'package:movieapp/presentation/splashScreen/splash_view.dart';

class Routes {
  static const spalshRoute = "/";
  static const homeRoute = "/home";
  static const favoritesRoute = "/favorites";
  static const historyRoute = "/history";
  static const movieListRoute = "/topMovies";
  static const movieDetailsRoute = "/movieDetails";
  static const watchRoute = "/watch";
  static const settingsRoute = "/settings";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.spalshRoute:
        initSplashModule();
        return CupertinoPageRoute(builder: (_) => SplashView());
      case Routes.homeRoute:
        initHomeModule();
        return CupertinoPageRoute(builder: (_) => HomeView());
      case Routes.favoritesRoute:
        initFavoritesModule();
        return CupertinoPageRoute(builder: (_) => FavoritesView());
      case Routes.historyRoute:
        initHistoryModule();
        return CupertinoPageRoute(builder: (_) => HistoryView());  
      case Routes.movieListRoute:
        initMovieListModule();
        MovieListArgs args = routeSettings.arguments as MovieListArgs;
        return CupertinoPageRoute(builder: (_) => MovieListView(args: args));
      case Routes.watchRoute:
        initMoviePlayerModule();
        String url = routeSettings.arguments as String;
        return CupertinoPageRoute(builder: (_) => MoviePlayer(url: url));
      case Routes.settingsRoute:
        initSettingsModule();
        return CupertinoPageRoute(builder: (_) => SettingsView());   
      case Routes.movieDetailsRoute:
        initMovieDetailsModule();
        int id = routeSettings.arguments as int;
        return CupertinoPageRoute(builder: (_) => MovieDetailsView(id: id));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound),
              ),
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}

class MovieListArgs {
  String endPoint;
  String titleAppBar;
  AppBarState appBarState; 
  MovieListArgs(this.endPoint,this.titleAppBar,{AppBarState? appBarState}): appBarState=appBarState??NormalAppBarState();
}
