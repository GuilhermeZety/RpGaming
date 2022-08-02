// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/pages/home/home_page.dart';
import 'package:rpgaming/src/pages/load/load_page_viewmodel.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';


class LoadPage extends StatefulWidget {
  static const String route = '/';
  const LoadPage({Key? key}) : super(key: key);

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  final controller = LoadPageViewModel();
  
  @override
  void initState() {
    super.initState();

    Timer.run(() => controller.load());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(supabase.auth.currentUser != null){
      Timer(const Duration(seconds: 3), () => to(context, const HomePage()));
    }else{
      Timer(const Duration(seconds: 3), () => to(context, const LoginPage()));
    }
    
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