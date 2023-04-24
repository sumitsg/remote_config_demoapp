import 'package:flutter/material.dart';

class CustomTextStyles {
  CustomTextStyles._internal();

  static final CustomTextStyles instance = CustomTextStyles._internal();

  factory CustomTextStyles() => instance;

  TextStyle normalText(
      {FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.grey,
      FontStyle? fontStyle}) {
    return TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 16,
        fontStyle: fontStyle);
  }

  TextStyle lgText(
      {FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.grey,
      double? fontSize}) {
    return TextStyle(fontWeight: fontWeight, color: color, fontSize: 18);
  }

  TextStyle smTextSemiBold(
      {FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.white,
      double? fontSize}) {
    return TextStyle(fontWeight: fontWeight, color: color, fontSize: 12);
  }

  TextStyle xxLgBoldText(
      {FontWeight fontWeight = FontWeight.bold,
      Color color = Colors.white,
      double? fontSize}) {
    return TextStyle(fontWeight: fontWeight, color: color, fontSize: 16);
  }
}
