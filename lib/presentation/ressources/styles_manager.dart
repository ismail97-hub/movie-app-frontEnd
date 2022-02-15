import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

//light style
TextStyle getLightStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManger.light, color);
}

//regular style
TextStyle getRegularStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManger.regular, color);
}

//medium style
TextStyle getMediumStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManger.medium, color);
}

//semi bold style
TextStyle getSemiBoldStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManger.semiBold, color);
}

//bold style
TextStyle getBoldStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManger.bold, color);
}
