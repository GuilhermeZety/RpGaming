import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rpgaming/src/components/Logo.dart';

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