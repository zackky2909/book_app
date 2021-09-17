// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_const_constructors
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback? press;
  final String? text;
  final Color? color;
  final Color? textColor;
  BottomButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.textColor,
      required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: press,
            child: Text(
              text!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: textColor),
            )));
  }
}
