import 'dart:async';
import 'dart:ffi';

import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/local/repository/favorite_repository.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/favorite_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/ressources/assets_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteViewModel extends BaseViewModel
    with FavoriteViewModelInput, FavoriteViewModelOutput {
  StreamController _favoritesStreamController = BehaviorSubject<List<Favorite>>();

  FavoriteUseCase _useCase;
  FavoriteViewModel(this._useCase);

  @override
  void start() async {
    getFavorites();
  }

  void getFavorites() async {
    inputState.add(ContentState());
    List<Favorite> favorites = await _useCase.getAll();
    if (favorites.isEmpty) {
      inputState.add(EmptyState(AppStrings.emptyFavorites, JsonAssets.favorite));
    } else {
      inputFavorites.add(favorites);
    }
  }

  @override
  void dispose() {
    _favoritesStreamController.close();
    super.dispose();
  }

  @override
  delete(int? id) async {
    await _useCase.delete(id);
    getFavorites();
  }

  @override
  Sink get inputFavorites => _favoritesStreamController.sink;

  @override
  Stream<List<Favorite>> get outputFavorites =>
      _favoritesStreamController.stream.map((favorites) => favorites);
}

abstract class FavoriteViewModelInput {
  delete(int id);
  Sink get inputFavorites;
}

abstract class FavoriteViewModelOutput {
  Stream<List<Favorite>> get outputFavorites;
}
