import 'package:movieapp/data/network/app_api/app_api.dart';
import 'package:movieapp/data/request/request.dart';
import 'package:movieapp/data/responses/response.dart';

abstract class RemoteDataSource {
  Future<List<MovieResponse>> trending();
  Future<List<MovieResponse>> newMovie();
  Future<List<MovieResponse>> topMovie();
  Future<HomeResponse> home();
  Future<MovieDetailsResponse> movieDetails(String id);
  Future<List<MovieResponse>> movieList(String arg);
  Future<List<MovieResponse>> search(String query);
  Future<UserInfoResponse> userInfo();
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
  Future<String> view(String id);
  Future<bool> favorite(String id);
  Future<List<MovieResponse>> myFavorite();
  Future<List<MovieResponse>> history();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<List<MovieResponse>> newMovie() async {
    return _appServiceClient.newMovie();
  }

  @override
  Future<List<MovieResponse>> topMovie() async {
    return _appServiceClient.topMovie();
  }

  @override
  Future<List<MovieResponse>> trending() async {
    return _appServiceClient.trending();
  }

  @override
  Future<HomeResponse> home() async {
    return _appServiceClient.home();
  }

  @override
  Future<MovieDetailsResponse> movieDetails(String id) {
    return _appServiceClient.movieDetails(id);
  }

  @override
  Future<List<MovieResponse>> movieList(String arg) {
    return _appServiceClient.movieList(arg);
  }

  @override
  Future<UserInfoResponse> userInfo() {
    return _appServiceClient.getInfo();
  }

  @override
  Future<List<MovieResponse>> search(String query) {
    return _appServiceClient.search(query);
  }

  @override
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest) {
    return _appServiceClient.signUp(
      signUpRequest.username,
      signUpRequest.password,
      signUpRequest.deviceType,
      signUpRequest.ip,
      signUpRequest.country,
      signUpRequest.region,
      signUpRequest.regionName,
      signUpRequest.city,
      signUpRequest.zip,
      signUpRequest.latitude,
      signUpRequest.longitude,
      signUpRequest.timezone,
      signUpRequest.isp,
      signUpRequest.fireBaseToken
    );
  }

  @override
  Future<String> view(String id) {
    return _appServiceClient.view(id);
  }

  @override
  Future<bool> favorite(String id) {
    return _appServiceClient.favorite(id);
  }

  @override
  Future<List<MovieResponse>> history() {
    return _appServiceClient.history();
  }

  @override
  Future<List<MovieResponse>> myFavorite() {
    return _appServiceClient.myFavorite();
  }

}
