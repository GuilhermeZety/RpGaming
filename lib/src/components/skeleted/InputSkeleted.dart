import 'package:flutter/material.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:skeletons/skeletons.dart';

class InputSkeleted extends StatelessWidget {
  const InputSkeleted({Key? key, required this.child, required this.isLoading, }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      skeleton: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 25),
        child: Input(
          type: TextInputType.name, 
          label: Text(''), 
          hintText: '',
          backgroundColor: Colors.black,
          height: 43,

        ),
      ),
      child: child
    );
  }
}