

import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/base_usecase.dart';

class MovieDetailsUseCase extends BaseUseCase<String,MoviesDetailsData> {
  Repository _repository;
  MovieDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, MoviesDetailsData>> execute(String input) async{
    return _repository.movieDetails(input);
  }

  Future<Either<Failure,String>> view(String id)async {
    return _repository.view(id);
  }

  Future<Either<Failure,bool>> favorite(String id)async {
    return _repository.favorite(id);
  }
      
}