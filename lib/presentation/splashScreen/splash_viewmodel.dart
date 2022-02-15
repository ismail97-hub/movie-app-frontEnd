import 'dart:async';
import 'dart:ffi';

import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/data/network/failure.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/splash_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/splashScreen/splash_view.dart';
import 'package:rxdart/rxdart.dart';

class SplashViewModel extends BaseViewModel
    with SplashViewModelInput, SplashViewModelOutput {
  StreamController goNextStreamController = BehaviorSubject<String>();   
  SplashUseCase _splashUseCase;
  AppPreferences _appPreferences;
  SplashViewModel(this._splashUseCase,this._appPreferences);
  Timer? timer;
  late String token;
  
  @override
  void start()async{
    inputState.add(ContentState());
    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();
    if (isUserLoggedIn) {
      token = await _appPreferences.getToken();
      _startTimer(token);
    } else {
      getInfo();
    }
  }

  _startTimer(String token) {
    timer = Timer(Duration(seconds: 3), (){intputgoNext.add(token);});
  }

  getInfo() async {
    (await _splashUseCase.execute(Void)).fold((failure) {
      print(failure.message);
      inputState.add(ErrorState(failure.message,StateRendererType.POPUP_ERROR_STATE));
    }, (userInfo) {
      login(userInfo.toUseCaseInput());
    });
  }

  @override
  login(SplashUseCaseInput splashUseCaseInput) async {
    (await _splashUseCase.signUp(splashUseCaseInput)).fold((failure) {
      // print(failure.message);
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
  login(SplashUseCaseInput splashUseCaseInput);
  Sink get intputgoNext;
}

abstract class SplashViewModelOutput {
  Stream<String> get outputgoNext;
}

extension UserInfoExtension on UserInfo {
  SplashUseCaseInput toUseCaseInput() {
    return SplashUseCaseInput(
      query,
      country,
      region,
      regionName,
      city,
      zip,
      lat,
      lon,
      timezone,
      isp,
    );
  }
}
