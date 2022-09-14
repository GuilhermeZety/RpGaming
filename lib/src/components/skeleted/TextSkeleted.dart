import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class TextSkeleted extends StatelessWidget {
  const TextSkeleted({Key? key, required this.isLoading, required this.sizeSkeleton, required this.child}) : super(key: key);

  final bool isLoading;
  final Size sizeSkeleton;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      skeleton: Container(
        width: sizeSkeleton.width,
        height: sizeSkeleton.height,
        color: Colors.black
      ),
      child: Container(        
        width: sizeSkeleton.width,
        height: sizeSkeleton.height,
        child: child
      )
    );
  }
}