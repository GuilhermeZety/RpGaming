import 'package:flutter/material.dart';

import 'animated-gradient.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key, 
    required this.child, 
    required this.sizeSkeleton, 
    required this.isLoading, 
    this.borderRadius = 0, 
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final Widget child;
  final Size sizeSkeleton;
  final bool isLoading;
  final double borderRadius;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return AnimatedGradient(
        size: sizeSkeleton,
        borderRadius: borderRadius,
        margin: margin,
      );
    }
    return child;
  }
}