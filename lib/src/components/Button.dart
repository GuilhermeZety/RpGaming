// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    Key? key, 
    required this.text, 
    required this.onPress, 
    required this.size, 
    this.colorInverted = false, 
    this.borderRadius = 10,
    this.bold = false,
    this.fontSize = 16,
  }) : super(key: key);

  final String text;
  final Future<void> Function()? onPress;
  final Size size;
  final bool colorInverted;
  final double borderRadius;
  final bool bold;
  final double fontSize;


  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Timer.run(() => load());
  }

  load(){
    setState(() {
      loading = false;
    });
  }

  onPressed() async {      
    setState(() {
      loading = true;
    });    

    await widget.onPress!();
         
    setState(() {
      loading = false;
    });    
  }

  
  @override
  Widget build(BuildContext context) {
    late final ColorScheme colors = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: () async => await onPressed(), style: ButtonStyle(
      elevation: MaterialStateProperty.all<double?>(4),
      minimumSize: MaterialStateProperty.all<Size?>(widget.size),
      backgroundColor: widget.colorInverted == false ?
        loading ? MaterialStateProperty.all<Color?>(colors.primary.withOpacity(0.5)) : MaterialStateProperty.all<Color?>(colors.primary)
        :
        loading ? MaterialStateProperty.all<Color?>(const Color(0xFF06071A).withOpacity(0.5)) : MaterialStateProperty.all<Color?>(const Color(0xFF06071A)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius)
        )
      ),
    ), 
    child: loading ?
      SizedBox(
        height: widget.size.height * 0.5,
        width: widget.size.height * 0.5,
        child: const CircularProgressIndicator(color: Colors.white,)
      )
    :
    Text(widget.text, style: TextStyle(fontSize: widget.fontSize, fontWeight: widget.bold ? FontWeight.w700 : FontWeight.normal),), );
  }
}