class BaseType {
  int id;
  String label;
  String labelEn;

  BaseType(this.id, this.label,this.labelEn);
}

class Category extends BaseType {
  Category(int id, String label,String labelEn) : super(id, label,labelEn);
}

class Genre extends BaseType {
  Genre(int id, String label,String labelEn) : super(id, label,labelEn);
}

class Movie {
  int id;
  String title;
  String image;
  Category category;
  List<Genre> genres;
  double rating;
  String quality;
  String year;
  String language;
  String country;
  String story;
  String source;
  String datePublication;
  int numOfFavorites;
  int numOfViews;
  bool isFavorite;
  bool isViewed;

  Movie(
    this.id,
    this.title,
    this.image,
    this.category,
    this.genres,
    this.rating,
    this.quality,
    this.year,
    this.language,
    this.country,
    this.story,
    this.source,
    this.datePublication,
    this.numOfFavorites,
    this.numOfViews,
    this.isFavorite,
    this.isViewed
  );
}

class HomeData {
  List<Movie> newMovies;
  List<Movie> trending;
  List<Movie> foreignMovies;
  List<Movie> indianMovies;
  List<Movie> arabicMovies;
  List<Category> categories;
  List<Genre> genres;

  HomeData(this.newMovies, this.trending, this.foreignMovies, this.indianMovies,
      this.arabicMovies, this.categories, this.genres);
}

class MoviesDetailsData {
  Movie movie;
  List<Movie> relatedMovies;

  MoviesDetailsData(this.movie, this.relatedMovies);
}

class UserInfo {
  String status;
  String country;
  String countryCode;
  String region;
  String regionName;
  String city;
  String zip;
  double lat;
  double lon;
  String timezone;
  String isp;
  String query;
  
  UserInfo(
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.query,
  );
}


class DeviceInfo {
  String name;
  String identifier;
 
  DeviceInfo(this.name, this.identifier);
}

