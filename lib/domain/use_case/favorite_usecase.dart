import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/local/repository/favorite_repository.dart';

class FavoriteUseCase {
  FavoriteRepository _repository;
  FavoriteUseCase(this._repository);

  
  Future<List<Favorite>> getAll(){
    return _repository.getAll();
  }

  Future<void> delete(int? id) {
    return _repository.delete(id);
  }

}