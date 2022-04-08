import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdapativeTextButton extends StatelessWidget {
  final VoidCallback _onClick;
  final String _text;
  const AdapativeTextButton({
    Key? key,
    required VoidCallback onClick,
    required String text,
  })  : _onClick = onClick,
        _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: _onClick)
        : TextButton(
            onPressed: _onClick,
            child: Text(
              _text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
  }
}
