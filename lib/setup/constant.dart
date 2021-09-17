// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const color1 = Color(0xFF00264D);
const color2 = Color(0xFF00498D);
const color3 = Color(0xffBCD2E8);
const color4 = Color(0xFFF2F2F0);
const color5 = Color(0xFFed2939);
const kTextColor = Color(0xFF110011);
const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrinePink100 = Color(0xFFFEDBD0);

const linerColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [color1, color2],
);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

