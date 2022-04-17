import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/ressources/assets_manager.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:movieapp/presentation/splashScreen/splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashViewModel _viewModel = instance<SplashViewModel>();

  gonext() {
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }

  _bind() {
    _viewModel.start();
    _viewModel.goNextStreamController.stream.listen((token) {
      // SchedulerBinding.instance?.addPersistentFrameCallback((_) {
      print(token);
      gonext();
      //});
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _bind();
                }) ??
                Container();
          }),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(ImageAssets.splashLogo),
            ),
          ],
        ),
      ),
      bottomSheet: _getBottomSheet(),
    );
  }

  Widget _getBottomSheet() {
    return Container(
      color: ColorManager.primary,
      height: AppSize.s100,
      width: double.infinity,
      child: Column(children: [
        Text(
          Constant.appName,
          style: getBoldStyle(
              color: ColorManager.secondary, fontSize: FontSize.s25),
        ),
        Text(
          "v${Constant.version}",
          style: getRegularStyle(color: ColorManager.white.withOpacity(0.8)),
        ),
      ]),
    );
  }
}
