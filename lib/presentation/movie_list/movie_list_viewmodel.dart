import 'dart:async';
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/data/local/repository/favorite_repository.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/movie_list_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_appbar/state_appbar_impl.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/ressources/assets_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class MovieListViewModel extends BaseViewModel
    with MovieListViewModelInput, MovieListViewModelOutput {
  StreamController _movieListStreamController = BehaviorSubject<List<Movie>>();
  StreamController _searchValueStreamController = BehaviorSubject<String>();
  StreamController _enablePullDownStreamController = BehaviorSubject<bool>();
  RefreshController refreshController = RefreshController();
  int pageIndex = 0;

  MovieListUseCase _useCase;
  MovieListViewModel(this._useCase);

  @override
  void start() {}

  void getMovieList(String arg) async {
    inputState.add(LoadingState());
    (await _useCase.execute(arg)).fold((failure) {
      inputState.add(ErrorState(
          failure.message, StateRendererType.FULL_SCREEN_ERROR_STATE));
    }, (movies) {
      inputEnablePullDown.add(true);
      inputState.add(ContentState());
      inputMovieList.add(movies);
    });
  }

  void onloading(List<Movie> movies, String arg) async {
    pageIndex++;
    print(pageIndex);
    (await _useCase
            .execute(arg + Constant.paginationEndPoint + pageIndex.toString()))
        .fold((failure) {
      inputState.add(ErrorState(
          failure.message, StateRendererType.FULL_SCREEN_ERROR_STATE));
    }, (fetchedmMovies) {
      if (fetchedmMovies.isEmpty) {
        inputEnablePullDown.add(false);
      } else {
        inputState.add(ContentState());
        for (var m in fetchedmMovies) {
          movies.add(m);
        }
        inputMovieList.add(movies);
        refreshController.loadComplete();
      }
    });
  }

  void search(String text) async {
    if (text.isNotEmpty) {
      inputState.add(LoadingState());
      (await _useCase.search(text)).fold((failure) {
        inputState.add(ErrorState(
            failure.message, StateRendererType.FULL_SCREEN_ERROR_STATE));
      }, (movies) {
        if (movies.isEmpty) {
          inputState.add(EmptyState(AppStrings.noResultFound, JsonAssets.notFound));
        } else {
          inputMovieList.add(movies);
          inputEnablePullDown.add(false);
          inputState.add(ContentState());
        }
      });
    }
  }

  @override
  void dispose() {
    _searchValueStreamController.close();
    _movieListStreamController.close();
    refreshController.dispose();
    _enablePullDownStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputMovieList => _movieListStreamController.sink;

  @override
  Stream<List<Movie>> get outputMovieList =>
      _movieListStreamController.stream.map((movieList) => movieList);

  @override
  Sink get inputSearchValue => _searchValueStreamController.sink;

  @override
  Stream<String> get outputSearchValue =>
      _searchValueStreamController.stream.map((value) => value);

  @override
  Sink get inputEnablePullDown => _enablePullDownStreamController.sink;

  @override
  Stream<bool> get outputEnablePullDown =>
      _enablePullDownStreamController.stream
          .map((isOnLoadingFinished) => isOnLoadingFinished);
}

abstract class MovieListViewModelInput {
  Sink get inputMovieList;
  Sink get inputSearchValue;
  Sink get inputEnablePullDown;
}

abstract class MovieListViewModelOutput {
  Stream<List<Movie>> get outputMovieList;
  Stream<String> get outputSearchValue;
  Stream<bool> get outputEnablePullDown;
}
