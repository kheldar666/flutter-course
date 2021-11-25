import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData iconData;

  final Function onPressed;

  RoundIconButton({@required this.iconData, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        this.iconData,
        color: Colors.white,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xff4c4f5e),
      constraints: BoxConstraints.tightFor(width: 56, height: 56),
      elevation: 0,
      onPressed: this.onPressed,
    );
  }
}
