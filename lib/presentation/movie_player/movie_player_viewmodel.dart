import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/subjects.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoviePlayerViewModel extends BaseViewModel
    with MoviePlayerViewModelInput, MoviePlayerViewModelOutput {
  StreamController _isPageFinishedstreamController = BehaviorSubject<bool>();    
  Timer? _timer;
  Timer? _backTimer;

  @override
  void start() {
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    inputState.add(ContentState());
    inputIsPageFinished.add(false);
    const duration = Duration(milliseconds: 3000);
    _timer = Timer.periodic(duration, (Timer t) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _backTimer?.cancel();
    _isPageFinishedstreamController.close();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Future<bool> onWillPop() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    inputIsPageFinished.add(false);
    return Future.delayed(const Duration(milliseconds: 500), () => true);
  }

  @override
  Sink get inputIsPageFinished => _isPageFinishedstreamController.sink;

  @override
  Stream<bool> get outputIsPageFinished => _isPageFinishedstreamController.stream.map((isPageFinished) => isPageFinished);
}

abstract class MoviePlayerViewModelInput {
  Future<bool> onWillPop();
  Sink get inputIsPageFinished;
}

abstract class MoviePlayerViewModelOutput {
  Stream<bool> get outputIsPageFinished;

}
