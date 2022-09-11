// ignore_for_file: avoid_returning_null_for_void



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/api/auth_state.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/DividerWithWidget.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:rpgaming/src/components/Logo.dart';
import 'package:rpgaming/src/pages/create-account/create_account_page.dart';
import 'package:rpgaming/src/pages/forgot-password/forgot-password-page.dart';
import 'package:rpgaming/src/pages/login/login_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/toasts.dart';
import '../../models/ResponseModel.dart';
import '../home/home_page.dart';



class LoginPage extends StatefulWidget {
  static const String route = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends AuthState<LoginPage> {
  final controller = LoginViewModel();  
  late FToast fToast;  

  @override
  initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    
    Timer.run(() => controller.onLoad(context));
  }   


  handleSignIn(Provider? provider) async {
    ResponseModel? response = await controller.signIn(provider);
    
    if(response != null){
      if(response.success){
        showSuccessToast(
          fToast: fToast,
          message: response.message,
        ); 
        to(context, HomePage());
      }
      else if(response.isWarning){
        showWarningToast(
          fToast: fToast,
          message: response.message,
        ); 
      }
      else {
        showErrorToast(
          fToast: fToast,
          error: response.message,
        ); 
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).backgroundColor,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height
        ),
        child: getContentBasedInSize()
      ),
    );
  }


  Widget getContentBasedInSize(){
    
    if(getWhatSize(context) == Orientation.landscape){
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Logue-se no', style: TextStyle(fontSize: 40),),
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
                        child: const Text('Insira suas informações abaixo ou acesse com uma conta social',textAlign: TextAlign.center,)
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Input(
                              controller: controller.emailController.value,
                              type: TextInputType.emailAddress,                            
                              label: const Text('Email'),
                              hintText: 'insira um email...',
                              obscure: false,
                            ),
                            Input(
                              controller: controller.passwordController.value,
                              type: TextInputType.visiblePassword,    
                              label: const Text('Senha'),
                              hintText: 'insira uma senha...',
                              obscure: true
                            ),                          
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight, 
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => to(context, const ForgotPasswordPage()),
                                  child: const Text('Esqueceu a senha?', style: TextStyle(decoration: TextDecoration.underline))
                                ),
                              )
                            ),
                            const SizedBox(height: 20),
                            Button(
                              onPress: () async {
                                await handleSignIn(null);
                              },
                              text: 'Entrar', 
                              size: Size(MediaQuery.of(context).size.width, 70),
                              bold: true,
                              fontSize: 20                            
                            ),
                            const SizedBox(height: 10),
                            DividerWithWidget(child: Text('ou continue com')),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  iconSize: 35,
                                  icon: SvgPicture.asset('assets/images/svg/google.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => handleSignIn(Provider.google),
                                ),
                                IconButton(
                                  iconSize: 37,
                                  icon: SvgPicture.asset('assets/images/svg/facebook.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => handleSignIn(Provider.facebook),
                                ),
                                IconButton(
                                  iconSize: 31,
                                  icon: SvgPicture.asset('assets/images/svg/discord.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => handleSignIn(Provider.discord),
                                ),
                                IconButton(
                                  iconSize: 31,
                                  icon: SvgPicture.asset('assets/images/svg/twitch.svg',
                                    semanticsLabel: 'Label'
                                  ),
                                  onPressed: () => handleSignIn(Provider.twitch),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não possui uma conta?'),
                                const SizedBox(width: 4),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async => await to(context, const CreateAccountPage()),
                                    child: const Text('Criar Conta', style: TextStyle(color: Color(0xFF666CDE), decoration: TextDecoration.underline, ), )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
          
          ],
      );
    }

    return Stack(
      children: [    
        Stack(
          children: [
            Image.asset('assets/images/wallpaper.png', fit: BoxFit.cover, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.45, alignment: Alignment.bottomCenter),
            const Center(
              heightFactor: 13,
              child: Logo()
            )
          ],
        ),    
        Positioned(
          bottom: 0,
          child: 
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.60,
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 45, right: 45),
            decoration: const BoxDecoration(
              color: Color(0xFF121222),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
            ),
            child: Form(
              onChanged: () => controller.formKey.currentState?.validate(),
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Input(
                    controller: controller.emailController.value,
                    type: TextInputType.emailAddress,                            
                    label: const Text('Email'),
                    hintText: 'insira um email...',
                    obscure: false,
                  ),
                  Input(
                    controller: controller.passwordController.value,
                    type: TextInputType.visiblePassword,    
                    label: const Text('Senha'),
                    hintText: 'insira uma senha...',
                    obscure: true
                  ),                          
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight, 
                    child: GestureDetector(
                      onTap: () => to(context, const ForgotPasswordPage()),
                      child: const Text('Esqueceu a senha?', style: TextStyle(decoration: TextDecoration.underline))
                    )
                  ),
                  const SizedBox(height: 9),
                  Button(
                    onPress: () async {
                      await handleSignIn(null);
                    },
                    text: 'Entrar', 
                    size: Size(MediaQuery.of(context).size.width, 70),
                    bold: true,
                    fontSize: 20                            
                  ),
                  const SizedBox(width: 10),
                  DividerWithWidget(child: Text('ou continue com',)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 35,
                        icon: SvgPicture.asset('assets/images/svg/google.svg',
                          semanticsLabel: 'Label'
                        ),
                        onPressed: () => handleSignIn(Provider.google),
                      ),
                      IconButton(
                        iconSize: 37,
                        icon: SvgPicture.asset('assets/images/svg/facebook.svg',
                          semanticsLabel: 'Label'
                        ),
                        onPressed: () => handleSignIn(Provider.facebook),
                      ),
                      IconButton(
                        iconSize: 31,
                        icon: SvgPicture.asset('assets/images/svg/discord.svg',
                          semanticsLabel: 'Label'
                        ),
                        onPressed: () => handleSignIn(Provider.discord),
                      ),
                      IconButton(
                        iconSize: 31,
                        icon: SvgPicture.asset('assets/images/svg/twitch.svg',
                          semanticsLabel: 'Label'
                        ),
                        onPressed: () => handleSignIn(Provider.twitch),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Não possui uma conta?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () async => await to(context, const CreateAccountPage()),
                        child: const Text('Criar Conta', style: TextStyle(color: Color(0xFF666CDE), decoration: TextDecoration.underline),)
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),                
      ]
    );
  }
}

