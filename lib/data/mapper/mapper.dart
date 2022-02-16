
import 'package:movieapp/data/responses/response.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/app/extensions.dart';

const EMPTY = "";
const ZERO = 0;
const ZERODOUBLE = 0.0;

extension CategoryResponseMapper on CategoryResponse? {
  Category toDomain() {
    return Category(
        this?.id?.orZero() ?? ZERO, this?.label?.orEmpty() ?? EMPTY);
  }
}

extension GenreResponseMapper on GenreResponse? {
  Genre toDomain() {
    return Genre(this?.id?.orZero() ?? ZERO, this?.label?.orEmpty() ?? EMPTY);
  }
}

extension ListCategoryResponseExtension on List<CategoryResponse>? {
  List<Category> toDomain() {
    List<Category>? categories =
        (this?.map((category) => category.toDomain()) ?? Iterable.empty())
            .cast<Category>()
            .toList();

    return categories;
  }
}

extension ListGenreResponseExtension on List<GenreResponse>? {
  List<Genre> toDomain() {
    List<Genre>? genres =
        (this?.map((genre) => genre.toDomain()) ?? Iterable.empty())
            .cast<Genre>()
            .toList();

    return genres;
  }
}

extension MovieResponseMapper on MovieResponse? {
  Movie toDomain() {
    List<GenreResponse>? genres = this?.genres;
    CategoryResponse? category = this?.category;

    return Movie(
      this?.id?.orZero() ?? ZERO,
      this?.title?.orEmpty() ?? EMPTY,
      this?.image?.orEmpty() ?? EMPTY,
      category.toDomain(),
      genres.toDomain(),
      this?.rating?.orZero() ?? ZERODOUBLE,
      this?.quality?.orEmpty() ?? EMPTY,
      this?.year?.orEmpty() ?? EMPTY,
      this?.language?.orEmpty() ?? EMPTY,
      this?.country?.orEmpty() ?? EMPTY,
      this?.story?.orEmpty() ?? EMPTY,
      this?.source?.orEmpty() ?? EMPTY,
      this?.datePublication?.orEmpty() ?? EMPTY,
      this?.numOfFavorites?.orZero()??ZERO,
      this?.numOfViews?.orZero()??ZERO,
      this?.isFavorite?.orFalse()??false,
      this?.isViewed?.orFalse()??false
    );
  }
}

extension ListMovieResponseExtension on List<MovieResponse>? {
  List<Movie> toDomain() {
    List<Movie>? movies =
        (this?.map((movie) => movie.toDomain()) ?? Iterable.empty())
            .cast<Movie>()
            .toList();

    return movies;
  }
}

extension HomeResponseExtension on HomeResponse? {
  HomeData toDomain() {
    List<MovieResponse>? newMovies = this?.newMovies;
    List<MovieResponse>? trending = this?.trending;
    List<MovieResponse>? foreignMovies = this?.foreignMovies;
    List<MovieResponse>? indianMovies = this?.indianMovies;
    List<MovieResponse>? arabicMovies = this?.arabicMovies;
    List<CategoryResponse>? categories = this?.categories;
    List<GenreResponse>? genres = this?.genres;

    return HomeData(
        newMovies.toDomain(),
        trending.toDomain(),
        foreignMovies.toDomain(),
        indianMovies.toDomain(),
        arabicMovies.toDomain(),
        categories.toDomain(),
        genres.toDomain());
  }
}

extension MovieDetailsResponseExtension on MovieDetailsResponse? {
  MoviesDetailsData toDomain() {
    MovieResponse? movie = this?.movie;
    List<MovieResponse>? relatedMovies = this?.relatedMovies;

    return MoviesDetailsData(movie.toDomain(), relatedMovies.toDomain());
  }
}

extension UserInfoResponseExtension on UserInfoResponse? {
  UserInfo toDomain() {
    return UserInfo(
      this?.status?.orEmpty() ?? "",
      this?.country?.orEmpty() ?? "",
      this?.countryCode?.orEmpty() ?? "",
      this?.region?.orEmpty() ?? "",
      this?.regionName?.orEmpty() ?? "",
      this?.city?.orEmpty() ?? "",
      this?.zip?.orEmpty() ?? "",
      this?.lat?.orZero() ?? 0.0,
      this?.lon?.orZero() ?? 0.0,
      this?.timezone?.orEmpty() ?? "",
      this?.isp?.orEmpty() ?? "",
      this?.query?.orEmpty() ?? "",
    );
  }
}
