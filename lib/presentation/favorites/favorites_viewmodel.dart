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
  StreamController _favoritesStreamController = BehaviorSubject<List<Movie>>();

  FavoriteUseCase _favoriteUseCase;
  FavoriteViewModel(this._favoriteUseCase);

  @override
  void start() async {
    getFavorites();
  }

  void getFavorites() async {
    
    inputState.add(LoadingState());
    (await _favoriteUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          failure.message, StateRendererType.FULL_SCREEN_ERROR_STATE));
    }, (favorites) {
      if (favorites.isEmpty) {
        inputState
            .add(EmptyState(AppStrings.emptyFavorites, JsonAssets.favorite));
      } else {
        inputFavorites.add(favorites);
        inputState.add(ContentState());
      }
    });
  }


  @override
  void dispose() {
    _favoritesStreamController.close();
    super.dispose();
  }
  
  @override
  unFavorite(List<Movie> favorites,Movie movie)async {
    (await _favoriteUseCase.unFavorite(movie.id.toString())).fold(
      (failure) {
        
      }, 
      (isFav) {
        favorites.remove(movie);
        inputFavorites.add(favorites);
      });
  }

  @override
  Sink get inputFavorites => _favoritesStreamController.sink;

  @override
  Stream<List<Movie>> get outputFavorites =>
      _favoritesStreamController.stream.map((favorites) => favorites);

}

abstract class FavoriteViewModelInput {
  unFavorite(List<Movie> favorites,Movie movie);
  Sink get inputFavorites;
}

abstract class FavoriteViewModelOutput {
  Stream<List<Movie>> get outputFavorites;
}
