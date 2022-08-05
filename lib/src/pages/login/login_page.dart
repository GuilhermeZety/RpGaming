// ignore_for_file: avoid_returning_null_for_void


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/api/auth_state.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/DividerWithWidget.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:rpgaming/src/components/Logo.dart';
import 'package:rpgaming/src/pages/create-account/create_account_page.dart';
import 'package:rpgaming/src/pages/forgot-password/forgot-password-page.dart';
import 'package:rpgaming/src/pages/home/home_page.dart';
import 'package:rpgaming/src/pages/login/login_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class LoginPage extends StatefulWidget {
  static const String route = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends AuthState<LoginPage> {
  final controller = LoginViewModel();

  
  handleSignIn(Provider? provider) async {
    if (provider == null) {
      if(controller.formKey.currentState!.validate()){
        try{
          GotrueSessionResponse res = await supabase.auth.signIn(
            email: controller.emailController.value.text,
            password: controller.passwordController.value.text
          );
          if(res.error != null){
            if(res.error!.message == 'Invalid login credentials'){
              context.showWarningSnackBar(message: 'Email ou senha inválidos');
            }
            else if(res.error!.message == "Email not confirmed"){
              context.showWarningSnackBar(message: 'Email não confirmado');
            }
            else{
              context.showWarningSnackBar(message: res.error!.message);
            }
          }
          else{
            if(res.data != null){
              context.showSuccessSnackBar(message: 'Logado com sucesso');
              to(context, HomePage());
            }
          }          
        }
        catch(err){
          context.showErrorSnackBar(error: err.toString());
        }
      }
    }    
    else{
      try{
        final res = await supabase.auth.signInWithProvider(
          provider,        
          options: AuthOptions(
            redirectTo: kIsWeb
              ? null
              : 'io.supabase.flutterquickstart://login-callback/'),
        );
        
        if(res == false){
          context.showWarningSnackBar(message: 'Não houve sucesso ao logar com o ${provider.name()}');
        }
      }
      catch(err){
        context.showErrorSnackBar(error: err.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Stack(
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
                  child: Container(
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
                          DividerWithWidget(child: Text('ou continue com')),
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
            )
      ),
    );
  }
}