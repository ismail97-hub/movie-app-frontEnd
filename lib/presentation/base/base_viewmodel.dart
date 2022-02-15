

import 'dart:async';

import 'package:movieapp/presentation/common/state_appbar/state_appbar_impl.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
  StreamController _inputStateStreamController = BehaviorSubject<FlowState>();
  StreamController _appBarStateStreamController = BehaviorSubject<AppBarState>();
  

  @override
  void dispose() {
    _inputStateStreamController.close();
    _appBarStateStreamController.close();
  }

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);
 
  @override
  Sink get inputAppBarState => _appBarStateStreamController.sink;

  @override
  Stream<AppBarState> get outputAppBarState => _appBarStateStreamController.stream.map((appBarState) => appBarState);
 
  

  
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  
  Sink get inputState;
  Sink get inputAppBarState;

}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState; 
  Stream<AppBarState> get outputAppBarState;
}