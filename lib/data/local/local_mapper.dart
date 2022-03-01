
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/domain/model/model.dart';

extension FavoriteExtension on Movie? {
  Favorite toFavorite() {
    Favorite favorite = Favorite();
    favorite.id = this?.id;
    favorite.title = this?.title;
    favorite.image = this?.image;
    favorite.rating = this?.rating;
    favorite.quality = this?.quality;
    favorite.year = this?.year;
    favorite.language = this?.language;
    favorite.country = this?.country;
    favorite.story = this?.story;
    favorite.datepublication = this?.datePublication;

    return favorite;
  }
}

extension HistoryExtension on Movie? {
  History toHistory() {
    History history = History();
    history.id = this?.id;
    history.title = this?.title;
    history.image = this?.image;
    history.rating = this?.rating;
    history.quality = this?.quality;
    history.year = this?.year;
    history.language = this?.language;
    history.country = this?.country;
    history.story = this?.story;
    history.datepublication = this?.datePublication;

    return history;
  }
}

extension LocalCategoryExtension on Category? {
  LocalCategory toLocal(){
    LocalCategory localCategory = LocalCategory();
    localCategory.id = this?.id;
    localCategory.label = this?.label;
    return localCategory;
  }
}

extension LocalGenreExtension on Genre? {
  LocalGenre toLocal(){
    LocalGenre localGenre = LocalGenre();
    localGenre.id= this?.id;
    localGenre.label = this?.label;
    return localGenre;
  }
}