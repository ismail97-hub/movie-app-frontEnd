import 'dart:io';
import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as intl;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/language_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + " " + build.model;
      identifier = await DeviceInformation.deviceIMEINumber;
    } else if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name + " " + build.model;
      identifier = build.identifierForVendor;
    }
  } on PlatformException {
    return DeviceInfo(name, identifier);
  }
  return DeviceInfo(name, identifier);
}

showSnackBar(BuildContext context, String content) {
  final snackBar = SnackBar(
    backgroundColor: ColorManager.secondary,
    content: Text(
      content.tr(),
      style: getMediumStyle(color: ColorManager.black),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<bool> isPhonePermissionGaranted() async {
  await [Permission.phone].request();
  final PermissionStatus permission = await Permission.phone.status;
  if (permission == PermissionStatus.granted) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

bool isArabic(BuildContext context) {
  return context.locale == ARABIC_LOCAL;
}

EdgeInsets paddingTr(BuildContext context,
    {required double padding, double? top, double? bottom}) {
  return EdgeInsets.only(
      top: top ?? AppPadding.p0,
      bottom: bottom ?? AppPadding.p0,
      left: isArabic(context) ? AppPadding.p0 : padding,
      right: isArabic(context) ? padding : AppPadding.p0);
}

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);
}

void share() {
  Share.share(Constant.shareText);
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    Fluttertoast.showToast(
        msg: AppStrings.urlLuncherError.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.secondary,
        textColor: ColorManager.primary,
        fontSize: FontSize.s16);
  }
}

dialogList(BuildContext context,
    {required String title, required List<Widget> children}) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: ColorManager.primary,
            title: Text(title.tr()),
            content: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: children));
      });
}
