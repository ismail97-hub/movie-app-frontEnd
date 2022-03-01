import 'package:flutter/material.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/presentation/home/drawer/app_drawer_header.dart';
import 'package:movieapp/presentation/home/home_viewmodel.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class AppDrawer extends StatelessWidget {
  final HomeViewModel viewModel;
  const AppDrawer({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: ColorManager.black.withOpacity(0.5),
      ),
      child: Drawer(
        child: Stack(
          children: [
            Scrollbar(
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    AppDrawerHeader(),
                    _getListTile(
                        context,
                        AppStrings.topMovies,
                        IconManager.top,
                        () => _goNext(context, Routes.movieListRoute,
                            args: MovieListArgs(
                                Endpoints.top, AppStrings.topMovies))),
                    _getListTile(
                        context,
                        AppStrings.newMovies,
                        IconManager.neW,
                        () => _goNext(context, Routes.movieListRoute,
                            args: MovieListArgs(
                                Endpoints.neW, AppStrings.newMovies))),
                    _getListTile(
                        context, AppStrings.byCategory, IconManager.category,
                        () async {
                      List<LocalCategory> categories =
                          await viewModel.getAllCategories();
                      await showTypesPopUp(context, AppStrings.byCategory,
                          categories.toTypeObject(), Endpoints.category);
                    }),
                    _getListTile(context, AppStrings.byGenre, IconManager.genre,
                        () async {
                      List<LocalGenre> genres = await viewModel.getAllGenres();
                      await showTypesPopUp(context, AppStrings.byGenre,
                          genres.toTypeObject(), Endpoints.genre);
                    }),
                    SizedBox(
                      height: AppSize.s24,
                    ),
                    _getListTile(
                        context,
                        AppStrings.favorites,
                        IconManager.favorite,
                        () => _goNext(context, Routes.favoritesRoute)),
                    _getListTile(context, AppStrings.history,
                        IconManager.history, () => _goNext(context, Routes.historyRoute)),
                    _getListTile(context, AppStrings.settings,
                        IconManager.settings, () {
                          _goNext(context, Routes.settingsRoute);
                        }),
                    _getListTile(context, AppStrings.contactUs,
                        IconManager.contactUs, () {}),
                    _getListTile(
                        context, AppStrings.share, IconManager.share, () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _goNext(BuildContext context, String routeName, {MovieListArgs? args}) {
    Navigator.pushNamed(context, routeName, arguments: args);
  }

  Widget _getListTile(
      BuildContext context, String title, IconData leading, Function() onTap) {
    return Center(
      child: ListTile(
        title: _getTitle(context, title),
        leading: _getTrailing(leading),
        onTap: onTap,
      ),
    );
  }

  Widget _getTrailing(IconData icon) {
    return Icon(
      icon,
      color: ColorManager.white,
      size: AppSize.s24,
    );
  }

  Widget _getTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  showTypesPopUp(BuildContext context, String title, List<TypeObject> types, String endPoint) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: ColorManager.primary,
              title: Text(title),
              content: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: types
                      .map((type) => ListTile(
                            title: Text(type.label),
                            trailing: Icon(IconManager.arrowForward,color: ColorManager.white,size: AppSize.s15,),
                            onTap: (){ _goNext(context, Routes.movieListRoute,
                                args: MovieListArgs(
                                    "$endPoint/${type.id}", type.label));},
                          ))
                      .toList()));
        });
  }
}

class TypeObject {
  int id;
  String label;

  TypeObject(this.id, this.label);
}

extension LocalCategoryExtension on List<LocalCategory>? {
  List<TypeObject> toTypeObject() {
    List<TypeObject>? types = (this?.map((category) => TypeObject(
                category.id ?? ZERO, category.label ?? EMPTY)) ??
            Iterable.empty())
        .cast<TypeObject>()
        .toList();
    return types;
  }
}

extension LocalGenreExtension on List<LocalGenre>? {
  List<TypeObject> toTypeObject() {
    List<TypeObject>? types = (this?.map((genre) =>
                TypeObject(genre.id ?? ZERO, genre.label ?? EMPTY)) ??
            Iterable.empty())
        .cast<TypeObject>()
        .toList();
    return types;
  }
}
