import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/splash_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class SplashViewModel extends BaseViewModel
    with SplashViewModelInput, SplashViewModelOutput {
  StreamController goNextStreamController = BehaviorSubject<String>();   
  SplashUseCase _splashUseCase;
  AppPreferences _appPreferences;
  FirebaseMessaging _firebaseMessaging;
  SplashViewModel(this._splashUseCase,this._appPreferences,this._firebaseMessaging);
  Timer? timer;
  late String token;
  
  @override
  void start()async{
    inputState.add(ContentState());
    initNotification();
    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();
    if (isUserLoggedIn) {
      token = await _appPreferences.getToken();
      _startTimer(token);
    } else {
      login();
    }
  }

  _startTimer(String token) {
    timer = Timer(Duration(seconds: 3), (){intputgoNext.add(token);});
  }
  
  initNotification()async{
    bool isNotificationAllowed = await _appPreferences.isNotificationAllowed();
    if (isNotificationAllowed){
      await _firebaseMessaging.subscribeToTopic(Constant.topic); 
    }
  }

  @override
  login() async {
    (await _splashUseCase.signUp(EMPTY)).fold((failure) {
      inputState.add(ErrorState(failure.message,StateRendererType.POPUP_ERROR_STATE));
    }, (token) {
      _appPreferences.setIsUserLoggedIn();
      _appPreferences.setToken(token);
      resetModule();
      intputgoNext.add(token);
    });
  }

  @override
  void dispose() {
    goNextStreamController.close();
    timer?.cancel();
    super.dispose();
  }

  @override
  Sink get intputgoNext=> goNextStreamController.sink;

  @override
  Stream<String> get outputgoNext => goNextStreamController.stream.map((token) => token);
}

abstract class SplashViewModelInput {
  login();
  Sink get intputgoNext;
}

abstract class SplashViewModelOutput {
  Stream<String> get outputgoNext;
}
