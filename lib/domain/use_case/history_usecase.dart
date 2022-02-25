
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/local/repository/history_repository.dart';

class HistoryUseCase {
  HistoryRepository _repository;
  HistoryUseCase(this._repository);
  
  Future<List<History>> getAll(){
    return _repository.getAll();
  }

}