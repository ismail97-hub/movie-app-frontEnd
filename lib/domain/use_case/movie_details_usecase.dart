

import 'package:flutter/material.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/local/repository/favorite_repository.dart';
import 'package:movieapp/data/local/repository/history_repository.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/base_usecase.dart';

class MovieDetailsUseCase extends BaseUseCase<String,MoviesDetailsData> {
  Repository _repository;
  HistoryRepository _historyRepository;
  FavoriteRepository _favoriteRepository;
  MovieDetailsUseCase(this._repository,this._historyRepository,this._favoriteRepository);

  @override
  Future<Either<Failure, MoviesDetailsData>> execute(String input) async{
    return _repository.movieDetails(input);
  }
   
  Future<int?> watch(Movie movie){
    return _historyRepository.save(movie);
  }

  Future<IconData> onFavoriteClick(Movie movie)async {
    return _favoriteRepository.onFavoriteClick(movie);
  }

  Future<IconData> getFavoriteIcon(int id)async {
    return _favoriteRepository.getFavoriteIcon(id);
  }    
}