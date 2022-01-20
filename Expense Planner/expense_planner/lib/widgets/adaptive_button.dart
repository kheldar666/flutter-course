import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AdaptiveButton({required this.label, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            onPressed: onPressed,
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(label),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
