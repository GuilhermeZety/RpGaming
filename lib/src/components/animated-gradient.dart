import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedGradient extends StatefulWidget {
  AnimatedGradient({required this.size, this.borderRadius = 0, this.margin = EdgeInsets.zero});

  final Size size;
  final double borderRadius;
  final EdgeInsets margin;
  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  @override
  void initState() {
    super.initState();
    Timer.run(() => onLoad());
  }

  onLoad() async {
    colorList = [
      Theme.of(context).primaryColor.withOpacity(0.1).withAlpha(10),
      Theme.of(context).primaryColor.withOpacity(0.1).withAlpha(40),
      Theme.of(context).primaryColor.withOpacity(1).withAlpha(90),
      Theme.of(context).primaryColor.withOpacity(0.1).withAlpha(40),
      Theme.of(context).primaryColor.withOpacity(0.1).withAlpha(10),
    ];

    setState(() {
      left = colorList[3];
      right = colorList[4];
    });

    if(mounted){
      Timer(Duration(milliseconds: 10), 
      (){
        setState(() {
          left = colorList.first;
        });
      }
      );
    }
  }

  List<Color> colorList = [];

  int index = 0;
  Color left = Color(0xFF171720);
  Color right = Color(0xFF171720);
  
  Alignment begin = Alignment.centerRight;
  Alignment end = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.size.width,
      height: widget.size.height,
      duration: Duration(milliseconds: 300),    
      margin: widget.margin,  
      onEnd: () {
        setState(() {
          index ++;

          left = colorList[index % colorList.length];
          right = colorList[(index + 1) % colorList.length];
        });
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin, 
          end: end, 
          colors: [left, right]
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius)
      ),
    );
  }
}
