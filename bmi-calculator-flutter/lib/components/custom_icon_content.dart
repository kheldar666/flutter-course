import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';

class CustomIconContent extends StatelessWidget {
  final IconData iconData;
  final String label;

  CustomIconContent({@required this.iconData, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          this.iconData,
          size: 80,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          this.label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
