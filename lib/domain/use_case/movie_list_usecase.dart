
import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/base_usecase.dart';

class MovieListUseCase extends BaseUseCase<String,List<Movie>>{
  Repository _repository;
  MovieListUseCase(this._repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(String input)async {
    return _repository.movieList(input);
  }

  Future<Either<Failure, List<Movie>>> search(String query)async {
    return _repository.search(query);
  }

  
    
}