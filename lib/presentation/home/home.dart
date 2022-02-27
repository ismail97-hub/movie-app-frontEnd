import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/common/state_appbar/state_appbar_impl.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/home/drawer/app_drawer.dart';
import 'package:movieapp/presentation/components/horizontal_list_item.dart';
import 'package:movieapp/presentation/home/components/movie_carousel.dart';
import 'package:movieapp/presentation/home/components/movie_swiper.dart';
import 'package:movieapp/presentation/home/home_viewmodel.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

import 'home_enum.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel _viewModel = instance<HomeViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  FirebaseMessaging _firebaseMessaging = instance<FirebaseMessaging>();
  _bind() {
    _viewModel.start();
    _firebaseMessaging.getToken().then((value) => print("fireBase token:"+value.toString()));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("MOVCIMA",
            style: getBoldStyle(fontSize: FontSize.s18, color: ColorManager.secondary)),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: _onTap(HomeSections.NEW_MOVIES
                  .getMovieListArgs(appBarState: SearchAppBarState())),
              icon: Icon(IconManager.search))
        ],
      ),
      drawer: AppDrawer(
        viewModel: _viewModel,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data
                        ?.getScreenWidget(context, _getContentWidget(), () {
                      _viewModel.start();
                    }) ??
                    Container();
              }),
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<HomeData>(
        stream: _viewModel.outputHomeData,
        builder: (context, snapshot) {
          HomeData? homeData = snapshot.data;
          if (homeData != null) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height>=AppSize.s800?AppSize.s100:AppSize.s80),
                _getSection(AppStrings.trending,
                    _onTap(HomeSections.TRENDING.getMovieListArgs())),
                _getCarousel(homeData.trending),
                _getSection(AppStrings.newMovies,
                    _onTap(HomeSections.NEW_MOVIES.getMovieListArgs())),
                _getListView(homeData.newMovies),
                _getSection(AppStrings.foreignMovies,
                    _onTap(HomeSections.FOREIGN_MOVIES.getMovieListArgs())),
                _getListView(homeData.foreignMovies),
                _getSection(AppStrings.indianMovies,
                    _onTap(HomeSections.INDIAN_MOVIES.getMovieListArgs())),
                _getListView(homeData.indianMovies),
                _getSection(AppStrings.arabicMovies,
                    _onTap(HomeSections.ARABIC_MOVIES.getMovieListArgs())),
                _getListView(homeData.arabicMovies),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget _getSection(String title, Function() onTap) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppPadding.p15,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppSize.s15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getBoldStyle(
                fontSize: FontSize.s15, color: ColorManager.secondary),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              AppStrings.viewAll,
              style: getSemiBoldStyle(
                  color: ColorManager.white.withOpacity(0.8),
                  fontSize: AppSize.s12),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSwiper(List<Movie> movies) {
    return MovieSwiper(movies);
  }

  Widget _getCarousel(List<Movie> movies) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: AppMargin.m30),
      child: MovieCarousel(
        movies,
        width: width >AppSize.s450?AppSize.s350:AppSize.s250,
        height: width >AppSize.s450?AppSize.s350:AppSize.s250,
        viewportFraction:  width >AppSize.s550?0.4:0.6,
      ),
    );
  }

  Widget _getListView(
    List<Movie> movies,
  ) {
    return Container(
      height: AppSize.s250,
      margin: EdgeInsets.only(left: AppMargin.m15, bottom: AppMargin.m20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: movies.map((movie) => HorizontalListmovie(movie)).toList(),
      ),
    );
  }

  Function() _onTap(MovieListArgs movieListArgs) {
    return () {
      Navigator.pushNamed(context, Routes.movieListRoute,
          arguments: movieListArgs);
    };
  }
}
