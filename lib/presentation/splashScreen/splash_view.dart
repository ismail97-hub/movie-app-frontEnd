import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.play, size: 100, color: ColorManager.secondary),
          SizedBox(height:20),
          Text(
            "MOVCIMA",
            style: getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s30),
          ),
        ],
      ),
    );
  }
}
