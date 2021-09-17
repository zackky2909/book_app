// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:test_register/presentation/UI/login/intro.dart';
import 'package:test_register/presentation/UI/login/splash_screen.dart';

final Map<String, WidgetBuilder> route = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Intro.routeName: (context) => Intro(),
};
