import 'package:flutter/material.dart';

import '../skeleton.dart';
class InputSkeleted extends StatelessWidget {
  const InputSkeleted({Key? key, required this.child, required this.isLoading, }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      borderRadius: 8,
      margin: EdgeInsets.only(top: 12, bottom: 26),
      sizeSkeleton: Size(double.infinity, 43),
      child: child
    );
  }
}