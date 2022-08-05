import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:rpgaming/src/components/Logo.dart';

class LoadViewModel extends ChangeNotifier {
  ValueNotifier<bool> init = ValueNotifier<bool>(false);
  ValueNotifier<bool> showLogo = ValueNotifier<bool>(false);
  ValueNotifier<double> position = ValueNotifier<double>(-5000);
  ValueNotifier<int> durationAnimateWave = ValueNotifier<int>(8000);
  ValueNotifier<double> angulo = ValueNotifier<double>(0);
 
  ValueNotifier<bool> changed = ValueNotifier<bool>(false);

  load() async {
      init.value = true;
      position.value = 0;
        
      Timer.periodic(const Duration(milliseconds: 1), (timer) => changed.value = !changed.value);

      Timer(Duration(milliseconds: durationAnimateWave.value - 2000), () => showLogo.value = true);
      Timer(Duration(milliseconds: durationAnimateWave.value), () {
        Timer.periodic(const Duration(milliseconds: 3000), (timer) { 
          angulo.value += 4/ 8;
          durationAnimateWave.value = 3000;
          getPosition();
        });
    });
  }

  getPosition(){
    if(position.value == 0){
      position.value = -1000;
    }
    else if(position.value == -1000){
      position.value = 0;
    }
  }

  Widget waveLeft(Color color){
    return WaveLeft(init: init.value, color: color, durationAnimateWave: durationAnimateWave.value, position: position.value);
  }
  Widget waveRight(Color color){
    return WaveRight(init: init.value, color: color, durationAnimateWave: durationAnimateWave.value, position: position.value);
  }
  Widget animatedLogo(){
    return AnimatedLogo(angulo: angulo.value, showLogo: showLogo.value,);
  }
}


class WaveLeft extends StatelessWidget {
  const WaveLeft({Key? key, required this.init, required this.position, required this.durationAnimateWave, required this.color}) : super(key: key);

  final bool init;
  final double position;
  final int durationAnimateWave;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: init ? MediaQuery.of(context).size.height * 0.9 - 2000 : -1850,
      left: position,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: durationAnimateWave),
      child: Image.asset('assets/images/waves.png', color: color,)
    );
  }
}

class WaveRight extends StatelessWidget {
  const WaveRight({Key? key, required this.init, required this.position, required this.durationAnimateWave, required this.color}) : super(key: key);

  final bool init;
  final double position;
  final int durationAnimateWave;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: init ? MediaQuery.of(context).size.height * 0.9 - 2000 : -1850,
      right: position,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: durationAnimateWave),
      child: Image.asset('assets/images/waves.png', color: color,)
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({Key? key, required this.showLogo, required this.angulo}) : super(key: key);

  final bool showLogo;
  final double angulo;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: showLogo ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height * 0.2,
      right: MediaQuery.of(context).size.width * 0.200,
      left: MediaQuery.of(context).size.width * 0.200,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 3000),
      child: AnimatedOpacity(
        opacity: showLogo ? 1 : 0,
        duration: const Duration(milliseconds: 3000),
        child: Center(child: Column(
          children: [
            AnimatedRotation(
              turns: angulo, 
              duration: const Duration(milliseconds: 2500),
              child: IconButton(
                iconSize: 90,
                icon: SvgPicture.asset('assets/images/svg/logo-vector.svg',
                  semanticsLabel: 'Label'
                ),
                onPressed: () => null,
              ),
            ),
            const SizedBox(height: 20),
            const Logo(),
          ],
        )),
      )
    );
  }
}