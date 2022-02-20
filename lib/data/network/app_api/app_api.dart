
import 'package:dio/dio.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/data/responses/response.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio ,{String baseUrl}) = _AppServiceClient;

  @GET("/movie/trending")
  Future<List<MovieResponse>> trending();

  @GET("/movie/new")
  Future<List<MovieResponse>> newMovie();

  @GET("/movie/top")
  Future<List<MovieResponse>> topMovie();

  @GET("/movie/{id}/related")
  Future<List<MovieResponse>> relatedMovie(@Path("id") String id);

  @GET("/movie/home")
  Future<HomeResponse> home();

  @GET("/movie/{id}/details")
  Future<MovieDetailsResponse> movieDetails(@Path("id") String id);
  
  @GET("/movie/{arg}")
  Future<List<MovieResponse>> movieList(@Path("arg") String arg);
  
  @GET("/movie/search/{query}")
  Future<List<MovieResponse>> search(@Path("query") String query);

  @POST("/movie/{id}/view")
  Future<String> view(@Path("id") String id);

  @POST("/movie/{id}/favorite")
  Future<bool> favorite(@Path("id") String id);
  
  @GET("/movie/myFavorite")
  Future<List<MovieResponse>> myFavorite();

  @GET("/movie/history")
  Future<List<MovieResponse>> history();

  @POST("/auth/signUp")
  Future<SignUpResponse> signUp(
    @Field("username") String username,
    @Field("password") String password,
    @Field("deviceType") String deviceType,
    @Field("ip") String ip,
    @Field("country") String country,
    @Field("region") String region,
    @Field("regionName") String regionName,
    @Field("city") String city,
    @Field("zip") String zip,
    @Field("latitude") double latitude,
    @Field("longitude") double longitude,
    @Field("timezone") String timezone,
    @Field("isp") String isp,
    @Field("fireBaseToken") String fireBaseToken,
  );  

  @GET(Constant.infoBaseUrl)
  Future<UserInfoResponse> getInfo();
}