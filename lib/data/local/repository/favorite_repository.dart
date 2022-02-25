
import 'package:flutter/material.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/data/local/local_mapper.dart';

abstract class FavoriteRepository {
  Future<IconData> onFavoriteClick(Movie movie);
  Future<IconData> getFavoriteIcon(int id);
  Future<List<Favorite>> getAll();
  Future<bool> isFavorite(int id);
  Future<int?> save(Movie? movie);
  Future<void> delete(int? id);
  Future<int> getCount();
}

class FavoriteRepositoryImpl extends FavoriteRepository {
  
  @override
  Future<IconData> onFavoriteClick(Movie movie) async {
    if (await isFavorite(movie.id)) {
      await delete(movie.id);
      return IconManager.emptyFavorite;
    } else {
      await save(movie);
      return IconManager.favorite;
    }
  }
  
  @override
  Future<List<Favorite>> getAll() async {
    return await Favorite().select().toList();
  }
  
  @override
  Future<bool> isFavorite(int id) async {
    if (await getCount() != 0) {
      return (await Favorite().select().movieId.equals(id).toSingle() != null);
    } else {
      return false;
    }
  }
  
  @override
  Future<int?> save(Movie? movie) async {
    Favorite favorite = movie.toFavorite();
    return await favorite.save();
  }
  
  @override
  Future<void> delete(int? id) async {
    await Favorite().select().movieId.equals(id).delete();
  }
  
  @override
  Future<int> getCount() async {
    List<Favorite> listOfFavorites = await getAll();
    return listOfFavorites.length;
  }

  @override
  Future<IconData> getFavoriteIcon(int id)async {
    if (await isFavorite(id)){
      return IconManager.favorite;      
    } else {
      return IconManager.emptyFavorite;
    }
  }
}

