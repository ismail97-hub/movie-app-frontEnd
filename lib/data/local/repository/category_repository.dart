import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/local/local_mapper.dart';

abstract class CategoryRepository {
  Future<int?> saveToLocal(Category? category);
  Future<void> deleteAll();
  Future<List<LocalCategory>> getAll();
  Future<int> getCount();
}

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<void> deleteAll() async{
    await LocalCategory().select().delete();
  }

  @override
  Future<List<LocalCategory>> getAll() async{
    return await LocalCategory().select().toList();
  }

  @override
  Future<int?> saveToLocal(Category? category) async{
     LocalCategory localCategory = category.toLocal();
     return await localCategory.save(); 
  }

  @override
  Future<int> getCount() async{
    List<LocalCategory> localcategoris = await getAll();
    return localcategoris.length;
  }
  
}