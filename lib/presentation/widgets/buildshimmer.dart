// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:test_register/presentation/widgets/shimmerwidget.dart';
import 'package:test_register/setup/constant.dart';

class BuildShimmer extends StatelessWidget {
  const BuildShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: 170,
      child: Card(
        color: color4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ShimmerWidget.rectangular(height: 220, width: 150)),
            ListTile(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                title: ShimmerWidget.rectangular(height: 18),
                subtitle: ShimmerWidget.rectangular(height: 12)),
          ],
        ),
      ),
    );
  }
}
