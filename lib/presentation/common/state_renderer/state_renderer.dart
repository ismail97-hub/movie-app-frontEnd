import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/presentation/ressources/assets_manager.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_ERROR_STATE,
  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String image;
  Function? retryActionFunction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      String? message,
      String? image,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        image = image ?? JsonAssets.loading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getColumnItems([_getAnimatedImage(JsonAssets.loading,AppSize.s250),_getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getColumnItems([
          _getAnimatedImage(JsonAssets.error,AppSize.s180),
          _getMessage(message),
          _getRetryActionButton()
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getColumnItems(
            [_getAnimatedImage(image,AppSize.s250), _getMessage(message)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [_getAnimatedImage(JsonAssets.error,AppSize.s180),
          _getMessage(message,color: ColorManager.white),
          _getRetryActionButton()]);
    }
  }

  Widget _getColumnItems(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animatedName,double width) {
    return SizedBox(
      height: AppSize.s180,
      width: width,
      child: Lottie.asset(animatedName),
    );
  }

  Widget _getMessage(String message,{Color? color}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style:
              getMediumStyle(fontSize: FontSize.s16, color: color??ColorManager.white),
        ),
      ),
    );
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.primary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }

   Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getRetryActionButton() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s140,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: ColorManager.secondary),
            onPressed: (){retryActionFunction?.call(); },
            child: Text(AppStrings.retryAgain,style: getSemiBoldStyle(color: ColorManager.white),),
          ),
        ),
      ),
    );
  }
}
