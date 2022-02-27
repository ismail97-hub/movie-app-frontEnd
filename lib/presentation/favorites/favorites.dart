import 'package:flutter/material.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/favorites/components/favorite_grid_item.dart';
import 'package:movieapp/presentation/favorites/components/favorite_list_item.dart';
import 'package:movieapp/presentation/favorites/favorites_viewmodel.dart';
import 'package:movieapp/presentation/movie_list/components/grid_item.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  FavoriteViewModel _viewModel = instance<FavoriteViewModel>();

  _bind() {
    _viewModel.start();
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
      appBar: AppBar(
        title: Text(AppStrings.favorites),
        elevation: AppSize.s4,
        actions: [IconButton(onPressed: () {}, icon: Icon(IconManager.info))],
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentScreen(), () {}) ??
                Container();
          }),
    );
  }

  Widget _getContentScreen() {
    return StreamBuilder<List<Favorite>>(
        stream: _viewModel.outputFavorites,
        builder: (context, snapshot) {
          return getListFavorites(snapshot.data);
        });
  }

  Widget getListFavorites(List<Favorite>? favorites) {
    if (favorites != null) {
      return Padding(
        padding: EdgeInsets.only(
          right: AppPadding.p5,
          left: AppPadding.p5,
        ),
        child: GridView.count(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 4 / 7,
          children: favorites.reversed
              .map((favorite) => FavoriteGridItem(
                    favorite,
                    unFavorite: () {
                      _viewModel.delete(favorite.movieId);
                    },
                    onTap: () {
                      Navigator.pushNamed(context, Routes.movieDetailsRoute,arguments: favorite.movieId)
                          .then((_) => _bind());
                    },
                  ))
              .toList(),
        ),
      );
    } else {
      return Container();
    }
  }
}
