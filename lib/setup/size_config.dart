// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class SizeConfig {
  static double? widthObject;
  static double? heightObject;
  late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  static double? horizontalScreen;
  static double? verticalScreen;

  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    horizontalScreen = _mediaQueryData.size.width;
    verticalScreen = _mediaQueryData.size.height;
  }

  void init_(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
    widthMultiplier = blockSizeHorizontal;
  }

  double textSize(inputTextsize) {
    return textMultiplier! * (inputTextsize / blockSizeHorizontal);
  }
}
