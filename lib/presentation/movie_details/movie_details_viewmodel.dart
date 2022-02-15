import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movieapp/data/local/repository/favorite_repository.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/movie_details_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsViewModel extends BaseViewModel
    with MovieViewModelInputs, MovieViewModelOutputs {
  StreamController _detailsDataStreamController = BehaviorSubject<MoviesDetailsData>();
  StreamController _favoriteIconStreamController = BehaviorSubject<IconData>();

  MovieDetailsUseCase _movieDetailsUseCase;
  MovieDetailsViewModel(this._movieDetailsUseCase);

  @override
  void start() async {
    
  }

  Future<void> getFavoriteIcon(bool isFavorite) async {
    print(isFavorite);
    if (isFavorite) {
      inputFavoriteIcon.add(IconManager.favorite);
    } else {
      inputFavoriteIcon.add(IconManager.emptyFavorite);
    }
  }

  @override
  onFavoriteClick(Movie movie) async{
    (await _movieDetailsUseCase.favorite(movie.id.toString())).fold(
      (failure) {
        print(failure.message);
      }, 
      (isFavorite) {
        movie.isFavorite = isFavorite;
        print(movie.isFavorite);
        getFavoriteIcon(movie.isFavorite);
      });
  }

  void getDetails(int id) async {
    inputState.add(LoadingState());
    (await _movieDetailsUseCase.execute("$id")).fold((failure) {
      inputState.add(ErrorState(
          failure.message, StateRendererType.FULL_SCREEN_ERROR_STATE));
    }, (moviesDetailsData) {
      print("isViewed :"+moviesDetailsData.movie.isViewed.toString());
      getFavoriteIcon(moviesDetailsData.movie.isFavorite);
      inputDetails.add(moviesDetailsData);
      inputState.add(ContentState());
    });
  }
  
  @override
  watch(BuildContext context, Movie movie) async{
    print(movie.isViewed);
    if (!movie.isViewed) {
      _setMovieIsViewed(context, movie.id.toString());
    }
    _goToMoviePlayer(context,movie.source);
  }

  @override
  void dispose() {
    _detailsDataStreamController.close();
    _favoriteIconStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputDetails => _detailsDataStreamController.sink;

  @override
  Sink get inputFavoriteIcon => _favoriteIconStreamController.sink;

  @override
  Stream<MoviesDetailsData> get outputDetails =>
      _detailsDataStreamController.stream.map((relatedMovies) => relatedMovies);

  @override
  Stream<IconData> get outputFavoriteIcon =>
      _favoriteIconStreamController.stream.map((favoriteIcon) => favoriteIcon);

  _goToMoviePlayer(BuildContext context,String url){
    Navigator.pushNamed(context, Routes.watchRoute,arguments: url);
  }

  _setMovieIsViewed(BuildContext context, String id)async{
    (await _movieDetailsUseCase.view(id)).fold(
      (failure) {
         print(failure);
      }, 
      (message) {
         print(message);
      });
  }

}

abstract class MovieViewModelInputs {
  watch(BuildContext context,Movie movie);
  onFavoriteClick(Movie movie);

  Sink get inputDetails;
  Sink get inputFavoriteIcon;
}

abstract class MovieViewModelOutputs {
  Stream<MoviesDetailsData> get outputDetails;
  Stream<IconData> get outputFavoriteIcon;
}
