// ignore_for_file: avoid_returning_null_for_void


import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/components/button.dart';
import 'package:rpgaming/src/components/input.dart';
import 'package:rpgaming/src/components/logo.dart';
import 'package:rpgaming/src/pages/create-account/create-account-viewmodel.dart';
import 'package:rpgaming/src/pages/login/login-page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class CreateAccountPage extends StatefulWidget {
  static const String route = '/create-account';
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final controller = CreateAccountViewModel();
  
  @override
  initState() {
    super.initState();
  }   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Observer(
          builder: (_) =>         
            getContentBasedInOrientation()
        )
      ),
    );
  }

  getContentBasedInOrientation(){
    if(isLandscape(context)){
      return Row(          
        children: [
          Container(
            child: Image.asset('assets/images/wallpaper.png', width: MediaQuery.of(context).size.width * 0.45, height: MediaQuery.of(context).size.height, fit: BoxFit.cover, alignment: Alignment.bottomCenter)
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Center(
              child: Container(
                width: 500,
                height: 700,
                padding: EdgeInsets.all(40),
                child: Form(
                  key: controller.formKey,
                  onChanged: () => controller.formKey.currentState!.validate(),
                  child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Criar conta no', style: TextStyle(fontSize: 40),),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 40,),
                                    Logo(),
                                  ],
                                )
                              ],
                            ),   
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 300,
                              child: const Text('Insira suas informa????es abaixo ou inscreva-se com uma conta social',textAlign: TextAlign.center,)
                            ),
                            SizedBox(
                              height: 10,
                            ),         
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [                                    
                                IconButton(
                                  iconSize: 35,
                                  icon: SvgPicture.asset('assets/images/svg/google.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => controller.handleSignIn(context, Provider.google),
                                ),
                                IconButton(
                                  iconSize: 37,
                                  icon: SvgPicture.asset('assets/images/svg/facebook.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => controller.handleSignIn(context, Provider.facebook),
                                ),
                                IconButton(
                                  iconSize: 31,
                                  icon: SvgPicture.asset('assets/images/svg/discord.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => controller.handleSignIn(context, Provider.discord),
                                ),
                                IconButton(
                                  iconSize: 31,
                                  icon: SvgPicture.asset('assets/images/svg/twitch.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => controller.handleSignIn(context, Provider.twitch),
                                ),
                              ],
                            ),
                            Input(
                              controller: controller.emailController,
                              type: TextInputType.emailAddress,                            
                              label: const Text('Email'),
                              hintText: 'insira um email...'
                            ),
                            Input(
                              controller: controller.passwordController,
                              type: TextInputType.visiblePassword,    
                              label: const Text('Senha'),
                              hintText: 'insira uma senha...',
                              obscure: true
                            ), 
                            Input(
                              controller: controller.repeatPasswordController,
                              type: TextInputType.visiblePassword,    
                              label: const Text('Confirmar senha'),
                              hintText: 'confirme sua senha...',
                              obscure: true,
                              compare: controller.passwordController
                            ), 
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Button(
                                  onPress: () async {
                                    await pushNamed(context, LoginPage.route);
                                  },
                                  text: 'Voltar',
                                  colorInverted: true,
                                  size: Size(200, 70),
                                  bold: true,
                                  fontSize: 20
                                ),
                                Button(
                                  onPress: () async => controller.validate(context, controller),
                                  text: 'Continuar', 
                                  size: Size(200, 70),
                                  bold: true,
                                  fontSize: 20
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      )
                    ]

                  ),
                )
              )
            )
          )
        ]
      );
    }
    return Stack(
      children: [       
        Image.asset('assets/images/wallpaper.png', fit: BoxFit.cover, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.45, alignment: Alignment.bottomCenter),   
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).viewInsets.bottom == 0 ? MediaQuery.of(context).size.height * 0.8 : MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.only(top: 30, bottom: 8, left: 45, right: 45),                    
            decoration: const BoxDecoration(
              color: Color(0xFF121222),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
            ),
            child: Form(
              key: controller.formKey,
              onChanged: () => controller.formKey.currentState!.validate(),
              child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Criar conta no', style: TextStyle(fontSize: 40),),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 40),
                                Logo(),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                                    
                            IconButton(
                              iconSize: 35,
                              icon: SvgPicture.asset('assets/images/svg/google.svg',
                                semanticsLabel: 'Label'
                              ),
                              onPressed: () => controller.handleSignIn(context, Provider.google),
                            ),
                            IconButton(
                              iconSize: 37,
                              icon: SvgPicture.asset('assets/images/svg/facebook.svg',
                                semanticsLabel: 'Label'
                              ),
                              onPressed: () => controller.handleSignIn(context, Provider.facebook),
                            ),
                            IconButton(
                              iconSize: 31,
                              icon: SvgPicture.asset('assets/images/svg/discord.svg',
                                semanticsLabel: 'Label'
                              ),
                              onPressed: () => controller.handleSignIn(context, Provider.discord),
                            ),
                            IconButton(
                              iconSize: 31,
                              icon: SvgPicture.asset('assets/images/svg/twitch.svg',
                                semanticsLabel: 'Label'
                              ),
                              onPressed: () => controller.handleSignIn(context, Provider.twitch),
                            ),
                          ],
                        ),
                        Input(
                          controller: controller.emailController,
                          type: TextInputType.emailAddress,                            
                          label: const Text('Email'),
                          hintText: 'insira um email...'
                        ),
                        Input(
                          controller: controller.passwordController,
                          type: TextInputType.visiblePassword,    
                          label: const Text('Senha'),
                          hintText: 'insira uma senha...',
                          obscure: true
                        ), 
                        Input(
                          controller: controller.repeatPasswordController,
                          type: TextInputType.visiblePassword,    
                          label: const Text('Confirmar senha'),
                          hintText: 'confirme sua senha...',
                          obscure: true,
                          compare: controller.passwordController
                        ), 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Button(
                              onPress: () async {
                                await to(context, const LoginPage());
                              },
                              text: 'Voltar',
                              colorInverted: true,
                              size: Size(MediaQuery.of(context).size.width * 0.37, 70),
                              bold: true,
                              fontSize: 20
                            ),
                            Button(
                              onPress: () async => controller.validate(context, controller),
                              text: 'Continuar', 
                              size: Size(MediaQuery.of(context).size.width * 0.37, 70),
                              bold: true,
                              fontSize: 20
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  )
                ]
              ),
            ),
          ),
        ),        
      ]
    );
  }
}