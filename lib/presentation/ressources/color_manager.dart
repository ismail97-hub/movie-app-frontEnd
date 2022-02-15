import 'package:flutter/material.dart';

class ColorManager {
  // static Color primary = HexColor.fromHex("#060A29");
  static Color primary = HexColor.fromHex("#101010");
  static Color secondary = HexColor.fromHex("#FBAC45");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color lightPrimary = HexColor.fromHex("#1E2746");
  static Color whiteOpacity70 = HexColor.fromHex("#B31E2746");
  static Color whiteOpacity20 = HexColor.fromHex("#331E2746");
  static Color red = HexColor.fromHex("#FC0000");
  // static Color red = HexColor.fromHex("#f3ca20 ");
  static Color yellow = HexColor.fromHex("#F9DF24");

  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black= HexColor.fromHex("#000000"); 

}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}