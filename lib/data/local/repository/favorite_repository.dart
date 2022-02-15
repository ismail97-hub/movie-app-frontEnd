
import 'package:flutter/material.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/data/local/local_mapper.dart';

abstract class FavoriteRepository {
  Future<IconData> onFavoriteClick(IconData? currentIcon, Movie? movie);
  Future<List<LocalFavorite>> getAllFavorite();
  Future<bool> isFavorite(int id);
  Future<int?> saveToFavorite(Movie? movie);
  Future<void> deleteFromFavorite(int? id);
  Future<int> getCountOfFavorites();
}

class FavoriteRepositoryImpl extends FavoriteRepository {
  
  @override
  Future<IconData> onFavoriteClick(IconData? currentIcon, Movie? movie) async {
    if (currentIcon == IconManager.emptyFavorite) {
      await saveToFavorite(movie);
      return IconManager.favorite;
    } else {
      await deleteFromFavorite(movie?.id);
      return IconManager.emptyFavorite;
    }
  }
  
  @override
  Future<List<LocalFavorite>> getAllFavorite() async {
    return await LocalFavorite().select().toList();
  }
  
  @override
  Future<bool> isFavorite(int id) async {
    if (await getCountOfFavorites() != 0) {
      return (await LocalFavorite().select().movieId.equals(id).toSingle() != null);
    } else {
      return false;
    }
  }
  
  @override
  Future<int?> saveToFavorite(Movie? movie) async {
    LocalFavorite localFavorite = movie.toLocal();
    return await localFavorite.save();
  }
  
  @override
  Future<void> deleteFromFavorite(int? id) async {
    await LocalFavorite().select().movieId.equals(id).delete();
  }
  
  @override
  Future<int> getCountOfFavorites() async {
    List<LocalFavorite> listOfFavorites = await getAllFavorite();
    return listOfFavorites.length;
  }
}

