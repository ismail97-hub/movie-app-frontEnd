import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/local/local_mapper.dart';

abstract class HistoryRepository {
  Future<int?> save(Movie? movie);
  Future<void> deleteAll();
  Future<List<History>> getAll();
  Future<int> getCount();
}

class HistoryRepositoryImpl extends HistoryRepository {
  @override
  Future<void> deleteAll() async{
    await History().select().delete();
  }

  @override
  Future<List<History>> getAll() async{
    return await History().select().toList();
  }

  @override
  Future<int?> save(Movie? movie) async{
     History history = movie.toHistory();
     return await history.upsert(); 
  }

  @override
  Future<int> getCount() async{
    List<History> history = await getAll();
    return history.length;
  }
  
}