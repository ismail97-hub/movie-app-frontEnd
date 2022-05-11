import 'package:flutter/material.dart';
import 'package:movieapp/app/ad_service.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/components/banner_ad_widget.dart';
import 'package:movieapp/presentation/favorites/components/favorite_grid_item.dart';
import 'package:movieapp/presentation/favorites/favorites_viewmodel.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  FavoriteViewModel _viewModel = instance<FavoriteViewModel>();
  AdService _adService = instance<AdService>();

  _bind() {
    _viewModel.start();
    _adService.createBannerAd();
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
      floatingActionButton: BannerAdWidget(ad: _adService.getBannerAd!),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(AppStrings.favorites.tr()),
        elevation: AppSize.s4,
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
                      _viewModel.delete(favorite.id);
                    },
                    onTap: () {
                      Navigator.pushNamed(context, Routes.movieDetailsRoute,
                              arguments: favorite.id)
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
