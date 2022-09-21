import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../login/login-page.dart';

import '../../Util/navigate.dart';
import '../../components/button.dart';

class NoSignalPage extends StatefulWidget {
  const NoSignalPage({Key? key}) : super(key: key);

  @override
  State<NoSignalPage> createState() => _NoSignalPageState();
}

class _NoSignalPageState extends State<NoSignalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal:  30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/svg/no-signal.svg', semanticsLabel: 'Label'),

              Text('Ooooops... Há algo de errado, não consigo identificar sua conexão com a internet...\n Por favor, verifique sua conexão e tente novamente :)', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),

              SizedBox(height: 60,),

              Button(
                onPress: () async {    
                  await to(context, LoginPage());              
                },
                text: 'Tentar Novamente', 
                size: Size(MediaQuery.of(context).size.width * 0.5, 70),
                bold: true,
                fontSize: 18                            
              ),
            ],
          ),
        ),
      ),
    );
  }
}