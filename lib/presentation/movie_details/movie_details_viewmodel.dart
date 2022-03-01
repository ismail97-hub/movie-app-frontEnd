import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/data/local/repository/favorite_repository.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/movie_details_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsViewModel extends BaseViewModel
    with MovieViewModelInputs, MovieViewModelOutputs {
  StreamController _detailsDataStreamController = BehaviorSubject<MoviesDetailsData>();
  StreamController _favoriteIconStreamController = BehaviorSubject<IconData>();

  MovieDetailsUseCase _useCase;
  MovieDetailsViewModel(this._useCase);

  @override
  void start() async {
    
  }

  init(int id){
    _getDetails(id);
    _getFavoriteIcon(id);
  }

  @override
  void dispose() {
    _detailsDataStreamController.close();
    _favoriteIconStreamController.close();
    super.dispose();
  }
 
  void _getDetails(int id) async {
    inputState.add(LoadingState());
    (await _useCase.execute("$id")).fold((failure) {
      inputState.add(ErrorState(failure.message, StateRendererType.FULL_SCREEN_ERROR_STATE));
    }, (moviesDetailsData) {
      inputDetails.add(moviesDetailsData);
      inputState.add(ContentState());
    });
  }
  
  void _getFavoriteIcon(int id)async{
    IconData currentIcon = await _useCase.getFavoriteIcon(id);
    inputFavoriteIcon.add(currentIcon);
  }

  @override
  onFavoriteClick(BuildContext context,Movie movie) async{
    IconData currentIcon = await _useCase.onFavoriteClick(movie,onSave: (){
      showSnackBar(context,AppStrings.addedToFavorite);
    });
    inputFavoriteIcon.add(currentIcon);
  }
  
  @override
  watch(BuildContext context, Movie movie) async{
    await _useCase.watch(movie).then((_) {
      _goToMoviePlayer(context, movie.source);
    });
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

}

abstract class MovieViewModelInputs {
  watch(BuildContext context,Movie movie);
  onFavoriteClick(BuildContext context,Movie movie);

  Sink get inputDetails;
  Sink get inputFavoriteIcon;
}

abstract class MovieViewModelOutputs {
  Stream<MoviesDetailsData> get outputDetails;
  Stream<IconData> get outputFavoriteIcon;
}
