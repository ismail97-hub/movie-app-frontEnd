
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/domain/model/model.dart';

extension LocalFavoriteExtension on Movie? {
  LocalFavorite toLocal() {
    LocalFavorite localFavorite = LocalFavorite();
    localFavorite.movieId = this?.id;
    localFavorite.title = this?.title;
    localFavorite.image = this?.image;
    localFavorite.rating = this?.rating;
    localFavorite.quality = this?.quality;
    localFavorite.year = this?.year;
    localFavorite.language = this?.language;
    localFavorite.country = this?.country;
    localFavorite.story = this?.story;
    localFavorite.datepublication = this?.datePublication;

    return localFavorite;
  }
}

extension LocalCategoryExtension on Category? {
  LocalCategory toLocal(){
    LocalCategory localCategory = LocalCategory();
    localCategory.identity = this?.id;
    localCategory.label = this?.label;
    return localCategory;
  }
}

extension LocalGenreExtension on Genre? {
  LocalGenre toLocal(){
    LocalGenre localGenre = LocalGenre();
    localGenre.identity= this?.id;
    localGenre.label = this?.label;
    return localGenre;
  }
}