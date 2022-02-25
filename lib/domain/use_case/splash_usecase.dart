import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/data/request/request.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/base_usecase.dart';

class SplashUseCase extends BaseUseCase<void, UserInfo> {
  Repository _repository;
  FirebaseMessaging _firebaseMessaging;
  SplashUseCase(this._repository,this._firebaseMessaging);
  
  @override
  Future<Either<Failure, UserInfo>> execute(void input) async{
    return await _repository.userInfo();
  }  
  
  Future<Either<Failure, String>> signUp(void input) async {
    String token = await _firebaseMessaging.getToken()??EMPTY;
    return await _repository.signIn(SignInRequest(Constant.client,Constant.client));
  }  
}

