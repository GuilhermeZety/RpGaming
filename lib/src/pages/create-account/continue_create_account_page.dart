// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/DateTimePicker.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:rpgaming/src/components/Logo.dart';
import 'package:rpgaming/src/enums/gender_person.dart';
import 'package:rpgaming/src/pages/create-account/create_account_viewmodel.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';

class ContinueCreateAccountPage extends StatefulWidget {
  static const String route = '/continue-create-account';
  const ContinueCreateAccountPage({Key? key,  this.controller}) : super(key: key);

  final CreateAccountViewModel? controller;

  @override
  State<ContinueCreateAccountPage> createState() => _ContinueCreateAccountPageState();
}

class _ContinueCreateAccountPageState extends State<ContinueCreateAccountPage> {
   late CreateAccountViewModel controller = CreateAccountViewModel();

  @override
  Widget build(BuildContext context) {
    if(widget.controller != null){
      setState(() {
        controller.emailController = widget.controller!.emailController;
        controller.passwordController = widget.controller!.passwordController;
        controller.repeatPasswordController = widget.controller!.repeatPasswordController;
      });
    }
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
                key: controller.formKey,
                onChanged: () => controller.formKey.currentState?.validate(),
                child: Column(
                  children: [
                    const Text('Insira o restante dos dados.'),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Input(
                            controller: controller.emailController.value,
                            type: TextInputType.emailAddress,
                            label: const Text('Email'),
                            hintText: 'insira um email...'
                          ),
                          Input(
                            controller: controller.passwordController.value,
                            type: TextInputType.visiblePassword,
                            label: const Text('Senha'),
                            hintText: 'insira uma senha...',
                            obscure: true
                          ),
                          Input(
                            controller: controller.repeatPasswordController.value,
                            type: TextInputType.visiblePassword,
                            label: const Text('Confirmar senha'),
                            hintText: 'confirme sua senha...',
                            obscure: true,
                            compare: controller.passwordController.value
                          ),
                          InputDateTime(dateController: controller.dateController.value, label: 'Data de nascimento', onchange: () => controller.formKey.currentState?.validate()),
                          AnimatedBuilder(
                            animation: controller.genderPerson,                            
                            builder: (context, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 75,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        child: DropdownButton<GenderPerson>(
                                          itemHeight: 50,
                                          dropdownColor: const Color(0xFF2F2F3C),
                                          value: controller.genderPerson.value,
                                          underline: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Color(0xFF737379),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                                          items: const [
                                            DropdownMenuItem(value: GenderPerson.male, child: Text('Masculino')),
                                            DropdownMenuItem(value: GenderPerson.female, child: Text('Feminino')),
                                            DropdownMenuItem(value: GenderPerson.other, child: Text('Outro')),
                                          ],
                                          onChanged: (value) => controller.setGender(value)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                controller.genderPerson.value == GenderPerson.other ?
                                  Flexible(child: Container(margin: const EdgeInsets.only(left: 20), child: const Input(type: TextInputType.text, label: Text('gênero'), hintText: 'Insira seu gênero...')))
                                : const SizedBox()
                              ],
                            ),
                          ),

                        ],
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(text: 'Voltar', onPress: () => to(context, const LoginPage()), size: const Size(100, 50), colorInverted: true, borderRadius: 15, ),
                        const SizedBox(width: 10),
                        Button(text: 'Confirmar', onPress: () => Future.delayed(Duration.zero, () =>  print('aaaaaa')) , size: const Size(100, 50), borderRadius: 15),
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