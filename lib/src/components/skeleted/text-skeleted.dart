import 'package:flutter/material.dart';

import '../skeleton.dart';

class TextSkeleted extends StatelessWidget {
  const TextSkeleted({Key? key, required this.isLoading, required this.sizeSkeleton, required this.child}) : super(key: key);

  final bool isLoading;
  final Size sizeSkeleton;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      sizeSkeleton: sizeSkeleton,
      borderRadius: 10,
      child: Container(        
        width: sizeSkeleton.width,
        height: sizeSkeleton.height,
        child: child
      )
    );
  }
}