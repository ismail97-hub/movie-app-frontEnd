import 'package:movieapp/data/data_source/local_data_source.dart';
import 'package:movieapp/data/data_source/remote_data_source.dart';
import 'package:movieapp/data/network/error_handler.dart';
import 'package:movieapp/data/network/network_info.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/data/request/request.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  NetworkInfo _networkInfo;
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;

  RepositoryImpl(this._networkInfo, this._remoteDataSource,this._localDataSource);

  @override
  Future<Either<Failure, HomeData>> home() async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.home();
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MoviesDetailsData>> movieDetails(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.movieDetails(id);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> movieList(String arg) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.movieList(arg);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserInfo>> userInfo() async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.userInfo();
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, String>> signIn(SignInRequest signInRequest)async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.signIn(signInRequest);
        return Right(response.token??EMPTY);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> signUp(SignUpRequest signUpRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.signUp(signUpRequest);
        return Right(response.token??EMPTY);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> search(String query) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.search(query);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> view(String id) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.view(id);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> favorite(String id) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.favorite(id);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> history() async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.history();
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> myFavorite() async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.myFavorite();
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


}
