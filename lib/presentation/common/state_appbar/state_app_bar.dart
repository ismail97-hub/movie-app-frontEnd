import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';

enum StateAppBarType { NORMAL_APPBAR, SEARCH_APPBAR }

AppBar stateAppBar(StateAppBarType stateAppBarType,{onPressed,onBack,onSubmitted,onChanged}) {
  switch (stateAppBarType) {
    case StateAppBarType.NORMAL_APPBAR:
      return AppBar();
    case StateAppBarType.SEARCH_APPBAR:
      return searchAppBar(onPressed,onBack,onSubmitted,onChanged);
  }
}

AppBar searchAppBar(Function() onPressed,Function() onBack,Function(String) onSubmitted,Function(String) onChanged) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(onPressed: onBack, icon: Icon(IconManager.back,color: ColorManager.secondary,)),
    title: TextField(
      style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s18),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      autofocus: true,
      onChanged: onChanged,
      cursorColor: ColorManager.secondary,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: AppStrings.searchHint.tr(),
        hintStyle: getRegularStyle(color: ColorManager.grey1,fontSize: FontSize.s18)
      ),
    ),
    actions: [
      IconButton(onPressed: onPressed, icon: Icon(IconManager.search,color: ColorManager.secondary,))],
  );
}
