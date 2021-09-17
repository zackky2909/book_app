// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:test_register/setup/constant.dart';

class CustomSnackbar {
  final String text;
  const CustomSnackbar({required this.text});

  static show(
    BuildContext context,
    String text,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: shrineBrown900,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: Text(text,
          style: TextStyle(
              color: shrinePink100,
              fontWeight: FontWeight.bold,
              fontFamily: 'Muli')),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    ));
  }
}
