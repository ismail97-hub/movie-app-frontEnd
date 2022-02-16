import 'package:json_annotation/json_annotation.dart';
import 'package:movieapp/domain/model/model.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseTypeResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "label")
  String? label;
}

@JsonSerializable()
class GenreResponse extends BaseTypeResponse {
  GenreResponse();

  // from json
  factory GenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$GenreResponseToJson(this);
}

@JsonSerializable()
class CategoryResponse extends BaseTypeResponse {
  CategoryResponse();

  // from json
  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "category")
  CategoryResponse? category;

  @JsonKey(name: "genres")
  List<GenreResponse>? genres;

  @JsonKey(name: "rating")
  double? rating;

  @JsonKey(name: "quality")
  String? quality;

  @JsonKey(name: "year")
  String? year;

  @JsonKey(name: "language")
  String? language;

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "story")
  String? story;

  @JsonKey(name: "source")
  String? source;

  @JsonKey(name: "datePublication")
  String? datePublication;
  
  @JsonKey(name: "numOfFavorites")
  int? numOfFavorites;

  @JsonKey(name: "numOfViews")
  int? numOfViews;

  @JsonKey(name: "favorite")
  bool? isFavorite;

  @JsonKey(name: "viewed")
  bool? isViewed; 

  MovieResponse(
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

  // from json
  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

@JsonSerializable()
class HomeResponse {
  @JsonKey(name: "trending")
  List<MovieResponse>? trending;

  @JsonKey(name: "newMovies")
  List<MovieResponse>? newMovies;

  @JsonKey(name: "foreignMovies")
  List<MovieResponse>? foreignMovies;

  @JsonKey(name: "indianMovies")
  List<MovieResponse>? indianMovies;

  @JsonKey(name: "arabicMovies")
  List<MovieResponse>? arabicMovies;

  @JsonKey(name: "categories")
  List<CategoryResponse>? categories;

  @JsonKey(name: "genres")
  List<GenreResponse>? genres;

  HomeResponse(this.trending, this.newMovies, this.foreignMovies,this.indianMovies,this.arabicMovies,this.categories,this.genres);

  //from json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}


@JsonSerializable()
class MovieDetailsResponse {
  @JsonKey(name: "movie")
  MovieResponse? movie;

  @JsonKey(name: "relatedMovies")
  List<MovieResponse>? relatedMovies;

  MovieDetailsResponse(this.movie, this.relatedMovies);

  //from json
  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$MovieDetailsResponseToJson(this);
}

@JsonSerializable()
class SignUpResponse {
  @JsonKey(name: "token")
  String? token;

  SignUpResponse(this.token);

  //from json
  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}


@JsonSerializable()
class UserInfoResponse {
  @JsonKey(name: "status")
  String? status;
  
  @JsonKey(name: "country")
  String? country;
  
  @JsonKey(name: "countryCode")
  String? countryCode;
  
  @JsonKey(name: "region")
  String? region;
  
  @JsonKey(name: "regionName")
  String? regionName;
  
  @JsonKey(name: "city")
  String? city;
  
  @JsonKey(name: "zip")
  String? zip;
  
  @JsonKey(name: "lat")
  double? lat;
  
  @JsonKey(name: "lon")
  double? lon;
  
  @JsonKey(name: "timezone")
  String? timezone;
  
  @JsonKey(name: "isp")
  String? isp;
  
  @JsonKey(name: "query")
  String? query;

  UserInfoResponse(
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

  //from json
  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}
