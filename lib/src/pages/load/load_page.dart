// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rpgaming/main.dart';
import 'package:rpgaming/src/api/auth_state.dart';
import 'package:rpgaming/src/pages/load/load_viewmodel.dart';


class LoadPage extends StatefulWidget {
  static const String route = '/';
  const LoadPage({Key? key}) : super(key: key);

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends AuthState<LoadPage> {
  final controller = LoadViewModel();
  
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      if(resetingPassword == false){
        Timer(const Duration(seconds: 10), () => recoverSupabaseSession());
      };
    });
    
    Timer.run(() => controller.load());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      AnimatedBuilder(
        animation: controller.changed,
        builder: (context, child) => Stack(
          children: [            
            controller.waveLeft(const Color(0xFF666CDE)),
            controller.waveRight(const Color(0xFF06071A)),
            controller.animatedLogo()
          ],
        ),
      )
    );
  }
}