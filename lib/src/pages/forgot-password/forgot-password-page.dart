// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:rpgaming/src/components/Logo.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = '/forgot-password';
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  // void _sendEmail() async {    
  //   if (_formKey.currentState!.validate()) {
  //     var response = await supabase.auth.api.resetPasswordForEmail(emailController.text);
  //     if(response.error != null){}
  //   }    
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Logo(),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1D27),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Form(
                key: _formKey,
                onChanged: () => _formKey.currentState?.validate(),
                child: Column(
                  children: [
                    const Text('Insira o email utilizado na conta.'),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Input(type: TextInputType.emailAddress, label: const Text('Email'), hintText: 'insira um email...', controller: emailController,)
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(text: 'Voltar', onPress: () => to(context, const LoginPage()), size: const Size(100, 50), colorInverted: true, borderRadius: 15, ),
                        const SizedBox(width: 10),
                        Button(text: 'Enviar', onPress: () async => context.showWarningSnackBar(message: 'Ainda não implementado, caso queira alterar, entra em contato com o email guilherme.zety@gmail.com'), size: Size(100, 50), borderRadius: 15),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}