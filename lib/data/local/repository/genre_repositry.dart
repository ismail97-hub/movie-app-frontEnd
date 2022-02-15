import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/data/local/local_mapper.dart';

abstract class GenreRepository {
  Future<int?> saveToLocal(Genre? genre);
  Future<void> deleteAll();
  Future<List<LocalGenre>> getAll();
  Future<int> getCount();
}

class GenreRepositoryImpl extends GenreRepository {
  @override
  Future<void> deleteAll() async {
    await LocalGenre().select().delete();
  }

  @override
  Future<List<LocalGenre>> getAll() async {
    return await LocalGenre().select().toList();
  }

  @override
  Future<int?> saveToLocal(Genre? genre) async {
    LocalGenre localGenre = genre.toLocal();
    return await localGenre.save();
  }

  @override
  Future<int> getCount() async{
    List<LocalGenre> localGenres = await getAll();
    return localGenres.length;
  }
}
