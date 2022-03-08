// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseTypeResponse _$BaseTypeResponseFromJson(Map<String, dynamic> json) =>
    BaseTypeResponse()
      ..id = json['id'] as int?
      ..label = json['label'] as String?
      ..labelEn = json['labelEn'] as String?;

Map<String, dynamic> _$BaseTypeResponseToJson(BaseTypeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'labelEn': instance.labelEn,
    };

GenreResponse _$GenreResponseFromJson(Map<String, dynamic> json) =>
    GenreResponse()
      ..id = json['id'] as int?
      ..label = json['label'] as String?
      ..labelEn = json['labelEn'] as String?;

Map<String, dynamic> _$GenreResponseToJson(GenreResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'labelEn': instance.labelEn,
    };

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse()
      ..id = json['id'] as int?
      ..label = json['label'] as String?
      ..labelEn = json['labelEn'] as String?;

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'labelEn': instance.labelEn,
    };

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['image'] as String?,
      json['category'] == null
          ? null
          : CategoryResponse.fromJson(json['category'] as Map<String, dynamic>),
      (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['rating'] as num?)?.toDouble(),
      json['quality'] as String?,
      json['year'] as String?,
      json['language'] as String?,
      json['country'] as String?,
      json['story'] as String?,
      json['source'] as String?,
      json['datePublication'] as String?,
      json['numOfFavorites'] as int?,
      json['numOfViews'] as int?,
      json['favorite'] as bool?,
      json['viewed'] as bool?,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'category': instance.category,
      'genres': instance.genres,
      'rating': instance.rating,
      'quality': instance.quality,
      'year': instance.year,
      'language': instance.language,
      'country': instance.country,
      'story': instance.story,
      'source': instance.source,
      'datePublication': instance.datePublication,
      'numOfFavorites': instance.numOfFavorites,
      'numOfViews': instance.numOfViews,
      'favorite': instance.isFavorite,
      'viewed': instance.isViewed,
    };

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      (json['trending'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['newMovies'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['foreignMovies'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['indianMovies'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['arabicMovies'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'trending': instance.trending,
      'newMovies': instance.newMovies,
      'foreignMovies': instance.foreignMovies,
      'indianMovies': instance.indianMovies,
      'arabicMovies': instance.arabicMovies,
      'categories': instance.categories,
      'genres': instance.genres,
    };

MovieDetailsResponse _$MovieDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MovieDetailsResponse(
      json['movie'] == null
          ? null
          : MovieResponse.fromJson(json['movie'] as Map<String, dynamic>),
      (json['relatedMovies'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsResponseToJson(
        MovieDetailsResponse instance) =>
    <String, dynamic>{
      'movie': instance.movie,
      'relatedMovies': instance.relatedMovies,
    };

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      json['token'] as String?,
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      json['status'] as String?,
      json['country'] as String?,
      json['countryCode'] as String?,
      json['region'] as String?,
      json['regionName'] as String?,
      json['city'] as String?,
      json['zip'] as String?,
      (json['lat'] as num?)?.toDouble(),
      (json['lon'] as num?)?.toDouble(),
      json['timezone'] as String?,
      json['isp'] as String?,
      json['query'] as String?,
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'region': instance.region,
      'regionName': instance.regionName,
      'city': instance.city,
      'zip': instance.zip,
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'isp': instance.isp,
      'query': instance.query,
    };
