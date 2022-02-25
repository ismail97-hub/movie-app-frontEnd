
import 'package:dartz/dartz.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:movieapp/data/request/request.dart';
import 'package:movieapp/domain/model/model.dart';

abstract class Repository {
   Future<Either<Failure,HomeData>> home();
   Future<Either<Failure,MoviesDetailsData>> movieDetails(String id);
   Future<Either<Failure,List<Movie>>> movieList(String arg);
   Future<Either<Failure,List<Movie>>> search(String query);
   Future<Either<Failure,UserInfo>> userInfo();
   Future<Either<Failure,String>> signUp(SignUpRequest signUpRequest);
   Future<Either<Failure,String>> signIn(SignInRequest signInRequest);
   Future<Either<Failure,String>> view(String id);
   Future<Either<Failure,bool>> favorite(String id);
   Future<Either<Failure,List<Movie>>> myFavorite();
   Future<Either<Failure,List<Movie>>> history();

}