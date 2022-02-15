import 'package:flutter/material.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();

  String getImage();
}

class LoadingState extends FlowState {
  String message;

  LoadingState({String? message}) : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.FULL_SCREEN_LOADING_STATE;

  @override
  String getImage() => EMPTY;
}

class ErrorState extends FlowState {
  String message;

  StateRendererType stateRendererType;
  ErrorState(this.message, this.stateRendererType);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getImage() => EMPTY;
}

class EmptyState extends FlowState {
  String message;
  String image;

  EmptyState(this.message, this.image);

  @override
  String getMessage() => message;

  @override
  String getImage() => image;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;

  @override
  String getImage() => EMPTY;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction);
      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            image: getImage(),
            retryActionFunction: retryActionFunction);
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
          // showing popup dialog
          showPopUp(context, getStateRendererType(), getMessage(),retryActionFunction);
          // return the content ui of the screen
          return contentScreenWidget;
        } else // StateRendererType.FULL_SCREEN_ERROR_STATE
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case ContentState:
        return contentScreenWidget;
      default:
        return contentScreenWidget;
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(
      BuildContext context, StateRendererType stateRendererType, String message,Function retryActionFunction) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryActionFunction: (){
                Navigator.of(context).pop();
                retryActionFunction.call();
              }
            )));
  }
}
