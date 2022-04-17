import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      splashColor: ColorManager.lightPrimary,
      errorColor: ColorManager.error,
      disabledColor: ColorManager.grey1,
      // card theme
      cardTheme: CardTheme(color: ColorManager.primary, elevation: AppSize.s4),
      iconTheme: IconThemeData(color: ColorManager.secondary),
      // AppBarTheme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: ColorManager.secondary),
          color: ColorManager.primary.withOpacity(0.6),
          elevation: AppSize.s0,
          titleTextStyle: getBoldStyle(
              fontSize: FontSize.s22, color: ColorManager.secondary)),
      // dialog Theme
      dialogTheme: DialogTheme(
        titleTextStyle: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s16),
        backgroundColor: ColorManager.white,
        contentTextStyle: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),
      ),
      // text Theme
      textTheme: TextTheme(
        headline1:
            getBoldStyle(fontSize: FontSize.s25, color: ColorManager.white),
        headline2:
            getBoldStyle(fontSize: FontSize.s18, color: ColorManager.white),
        headline3:
            getBoldStyle(fontSize: FontSize.s15, color: ColorManager.white),
        headline4:
            getMediumStyle(fontSize: FontSize.s22, color: ColorManager.white),
        headline5:
            getSemiBoldStyle(fontSize: FontSize.s15, color: ColorManager.white),
        headline6:
            getRegularStyle(fontSize: FontSize.s12, color: ColorManager.white),
        button:
            getRegularStyle(fontSize: FontSize.s15, color: ColorManager.white),
        subtitle1: getRegularStyle(
            fontSize: FontSize.s12, color: ColorManager.white.withOpacity(0.8)),
        subtitle2: getRegularStyle(
            fontSize: FontSize.s10, color: ColorManager.whiteOpacity70),
        bodyText1: getRegularStyle(
            fontSize: FontSize.s15, color: ColorManager.white.withOpacity(0.5)),
        bodyText2: getBoldStyle(
            fontSize: FontSize.s12,
            color: ColorManager.white.withOpacity(0.75)),
      )
      );
}
