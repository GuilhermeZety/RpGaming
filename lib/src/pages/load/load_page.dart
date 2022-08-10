// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rpgaming/main.dart';
import 'package:rpgaming/src/api/auth_state.dart';
import 'package:rpgaming/src/pages/load/animated_logo.dart';
import 'package:rpgaming/src/pages/load/load_viewmodel.dart';
import 'package:rpgaming/src/pages/load/wave.dart';


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
      Observer(
        builder: (_) => 
        Stack(
          children: [  
            Wave(
              positionBottom: controller.init ? MediaQuery.of(context).size.height * 0.9 - 2000 : -1850, 
              color: const Color(0xFF666CDE), 
              left: true,
              durationAnimateWave: controller.durationAnimateWave, 
              horizontalPosition: controller.position
            ),  
            Wave(
              positionBottom: controller.init ? MediaQuery.of(context).size.height * 0.9 - 2000 : -1850, 
              color: const Color(0xFF06071A), 
              left: false,
              durationAnimateWave: controller.durationAnimateWave, 
              horizontalPosition: controller.position
            ),
            AnimatedLogo(angulo: controller.angulo, showLogo: controller.showLogo)
          ],
        ),
      )
    );
  }
}