// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('RpGaming', style: TextStyle(color: Color(0xFFD7D7D7), fontFamily: 'Press Start 2P', fontSize: 25)),
        Text('.', style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'Press Start 2P', fontSize: 25)),
      ],
    );
  }
}