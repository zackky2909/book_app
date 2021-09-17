// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_register/setup/constant.dart';

class RowRemember extends StatefulWidget {
  RowRemember({Key? key}) : super(key: key);

  @override
  State<RowRemember> createState() => _RowRememberState();
}

class _RowRememberState extends State<RowRemember> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: color1.withOpacity(0.7), width: 0.8)),
          child: Checkbox(
              activeColor: color1,
              checkColor: Colors.white,
              value: isCheck,
              onChanged: (value) {
                setState(() {
                  isCheck = !isCheck;
                });
              }),
        ),
        SizedBox(width: 10),
        Text(
          'Remember me',
          style: TextStyle(color: color1.withOpacity(0.7), fontSize: 13),
        ),
        SizedBox(width: 40),
        Text(
          'Forget your paswword',
          style: TextStyle(color: color1.withOpacity(0.7), fontSize: 13),
        ),
      ],
    );
  }
}
