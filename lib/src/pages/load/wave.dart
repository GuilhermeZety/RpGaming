import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Wave extends StatelessWidget {
  const Wave({Key? key, 
    required this.positionBottom, 
    required this.left, 
    required this.horizontalPosition,
    required this.durationAnimateWave,
    required this.color,    
  }) : super(key: key);

  final double positionBottom;  
  final double horizontalPosition;  
  final int durationAnimateWave;  
  final Color color;  

  final bool left;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => left == true ?
        AnimatedPositioned(
          bottom: positionBottom,          
          left: horizontalPosition,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: durationAnimateWave),
          child: Image.asset('assets/images/waves.png', color: color,
          ) 
        )
        :
        AnimatedPositioned(
          bottom: positionBottom,          
          right: horizontalPosition,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: durationAnimateWave),
          child: Image.asset('assets/images/waves.png', 
            color: color,
          )
        )
      
    );
  }
}