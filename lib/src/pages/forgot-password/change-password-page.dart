// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:rpgaming/src/components/Logo.dart';
import 'package:rpgaming/src/pages/home/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String route = '/change-password';
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _handleResetPassword() async {
     if (_formKey.currentState!.validate()) {
      var response = await supabase.auth.api.updateUser(await supabase.auth.currentSession!.accessToken, UserAttributes(password: passwordController.text));

      if(response.error == null){
        context.showSuccessSnackBar(message: 'Senha alterada com sucesso!');
        to(context, HomePage());
      }
      else{
        context.showWarningSnackBar(message: response.error!.message);
      }
    }   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                      const Text('Ror favor insira sua nova senha.'),
                      
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Input(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,    
                          label: const Text('Senha'),
                          hintText: 'insira uma senha...',
                          obscure: true
                        ),
                      ), 
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Input(
                          controller: repeatPasswordController,
                          type: TextInputType.visiblePassword,    
                          label: const Text('Confirmar senha'),
                          hintText: 'confirme sua senha...',
                          obscure: true,
                          compare: passwordController
                        ),
                      ), 
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Button(text: 'Confirmar', onPress: () async => _handleResetPassword(), size: Size(100, 50), borderRadius: 15),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}