import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:rxdart/subjects.dart';

class SettingsViewModel extends BaseViewModel
    with SettingsViewModelInput, SettingsViewModelOutput {
  StreamController _isNotificaionAllowedStreamController =
      BehaviorSubject<bool>();

  AppPreferences _appPreferences;
  FirebaseMessaging _firebaseMessaging;
  SettingsViewModel(this._appPreferences,this._firebaseMessaging);    

  @override
  void start()async {
    bool isNotificatinAllowed = await _appPreferences.isNotificationAllowed();
    print(isNotificatinAllowed);
    inputIsNotificaitonAllowed.add(isNotificatinAllowed);
  }

  @override
  void dispose() {
    _isNotificaionAllowedStreamController.close();
    super.dispose();
  }

  @override
  onNotificationToggle(bool value) {
    if (value==false) {
      disAllowNotification();
    } else {
      allowNotification();
    }
    inputIsNotificaitonAllowed.add(value);
  }

  @override
  changeLanguage(BuildContext context) {
    _appPreferences.setLanguageChanged();
    Phoenix.rebirth(context); 
  }

  @override
  deleteFavorite(BuildContext context)async {
    await Favorite().select().delete().then((value) {
      showSnackBar(context, AppStrings.deleteFavoriteMessage);
    });
  }

  @override
  deleteHistory(BuildContext context) async{
    await History().select().delete().then((value) {
      showSnackBar(context, AppStrings.deleteHistoryMessage);
    });
  } 

  @override
  Sink get inputIsNotificaitonAllowed =>
      _isNotificaionAllowedStreamController.sink;

  @override
  Stream<bool> get outputIsNotificaitonAllowed =>
      _isNotificaionAllowedStreamController.stream
          .map((isNotificationAllowed) => isNotificationAllowed);

  allowNotification()async{
    await _firebaseMessaging.subscribeToTopic(Constant.topic);
    await _appPreferences.allowNotification();
  } 

  disAllowNotification()async{
    await _firebaseMessaging.unsubscribeFromTopic(Constant.topic);
    await _appPreferences.disAllowNotification();
  }

}

abstract class SettingsViewModelInput {
  changeLanguage(BuildContext context);
  onNotificationToggle(bool value);
  deleteFavorite(BuildContext context);
  deleteHistory(BuildContext context);
  Sink get inputIsNotificaitonAllowed;
}

abstract class SettingsViewModelOutput {
  Stream<bool> get outputIsNotificaitonAllowed;
}
