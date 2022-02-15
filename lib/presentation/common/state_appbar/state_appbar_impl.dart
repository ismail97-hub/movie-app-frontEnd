import 'package:flutter/material.dart';
import 'package:movieapp/presentation/common/state_appbar/state_app_bar.dart';

abstract class AppBarState {
  StateAppBarType getStateAppBarType();
}

class NormalAppBarState extends AppBarState{
  NormalAppBarState();

  @override
  StateAppBarType getStateAppBarType() => StateAppBarType.NORMAL_APPBAR;

}

class SearchAppBarState extends AppBarState{
  SearchAppBarState();

  @override
  StateAppBarType getStateAppBarType() => StateAppBarType.SEARCH_APPBAR;

}

extension AppBarStateExtension on AppBarState{
  AppBar getAppBar(AppBar getContentAppBar,{required Function() onPressed,required Function() onBack,required Function(String) onSubmitted,required Function(String) onChanged}){
     switch (this.runtimeType) {
       case NormalAppBarState:
         return getContentAppBar;
       case SearchAppBarState:
         return stateAppBar(getStateAppBarType(),onPressed: onPressed,onBack: onBack,onChanged: onChanged,onSubmitted: onSubmitted);
       default:
         return getContentAppBar;
     }
  }
}