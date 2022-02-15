import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/base_usecase.dart';

class FavoriteUseCase extends BaseUseCase<void,List<Movie>> {
  Repository _repository;
  FavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(void input) {
    return _repository.myFavorite();
  }
  
  Future<Either<Failure, bool>> unFavorite(String input) {
    return _repository.favorite(input);
  }

}