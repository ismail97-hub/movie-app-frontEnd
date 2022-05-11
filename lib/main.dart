import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/presentation/ressources/language_manager.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await MobileAds.instance.initialize(); // initialize mobile ads (admob)
  await initAppModule();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(EasyLocalization(
    supportedLocales: [ENGLISH_LOCAL, ARABIC_LOCAL],
    path: ASSETS_PATH_LOCALISATIONS,
    child: Phoenix(child:  MyApp())));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
