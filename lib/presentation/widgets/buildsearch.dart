// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildSearch extends StatelessWidget {
  const BuildSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 30),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14),
              hintText: 'Search',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0.5, color: Colors.blueGrey),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.5, color: Colors.blueGrey))),
        ),
      ),
    );
  }
}
