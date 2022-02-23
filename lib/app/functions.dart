import 'dart:io';
import 'package:device_information/device_information.dart';
import 'package:intl/intl.dart' as intl;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:permission_handler/permission_handler.dart';

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

Future<bool> isPhonePermissionGaranted()async {
  await [Permission.phone].request();
  final PermissionStatus permission = await Permission.phone.status;
  if (permission == PermissionStatus.granted) {
    return Future.value(true);
  }
  else{
    return Future.value(false);
  }
}

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);
}
