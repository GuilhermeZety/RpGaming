// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rpgaming/src/components/button.dart';
import 'package:rpgaming/src/components/input.dart';
import 'package:rpgaming/src/components/logo.dart';

import 'change-password-viewmodel.dart';


class ChangePasswordPage extends StatefulWidget {
  static const String route = '/change-password';
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var controller = ChangePasswordViewModel();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) => Center(
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
                    key: controller.formKey,
                    onChanged: () => controller.formKey.currentState?.validate(),
                    child: Column(
                      children: [
                        const Text('Ror favor insira sua nova senha.'),
                        
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Input(
                            controller: controller.passwordController,
                            type: TextInputType.visiblePassword,    
                            label: const Text('Senha'),
                            hintText: 'insira uma senha...',
                            obscure: true
                          ),
                        ), 
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Input(
                            controller: TextEditingController(),
                            type: TextInputType.visiblePassword,    
                            label: const Text('Confirmar senha'),
                            hintText: 'confirme sua senha...',
                            obscure: true,
                            compare: controller.passwordController
                          ),
                        ), 
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button(text: 'Confirmar', onPress: () async => controller.handleResetPassword(context), size: Size(100, 50), borderRadius: 15),
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
      ),
    );
  }
}