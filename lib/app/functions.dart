
import 'dart:io';
import 'package:device_information/device_information.dart';
import 'package:intl/intl.dart' as intl;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";

  // DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return android device info
      // var build = await deviceInfoPlugin.androidInfo;
      // name = build.brand + " " + build.model;
      name = await DeviceInformation.deviceName;
      identifier = await DeviceInformation.deviceIMEINumber;
    } else if (Platform.isIOS) {
      // // return ios device info
      // var build = await deviceInfoPlugin.iosInfo;
      // name = build.name + " " + build.model;
      // identifier = build.identifierForVendor;
    }
  } on PlatformException {
    // return default data here
    return DeviceInfo(name, identifier);
  }
  return DeviceInfo(name, identifier);
}

bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
}
