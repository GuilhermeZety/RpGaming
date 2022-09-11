// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/DateTimePicker.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:rpgaming/src/enums/gender_person.dart';
import 'package:rpgaming/src/pages/create-account/create_account_viewmodel.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/toasts.dart';

class ContinueCreateAccountPage extends StatefulWidget {
  static const String route = '/continue-create-account';

  const ContinueCreateAccountPage({Key? key,  this.controller}) : super(key: key);

  final CreateAccountViewModel? controller;

  @override
  State<ContinueCreateAccountPage> createState() => _ContinueCreateAccountPageState();
}

class _ContinueCreateAccountPageState extends State<ContinueCreateAccountPage> {
  late CreateAccountViewModel controller = CreateAccountViewModel();
  
  FToast fToast = FToast();

  @override
  initState() {
    super.initState();
    fToast.init(context);
  }   

  Future<void> _signUp() async {  
    if (controller.formKey.currentState!.validate()) {
      controller.correctFields();

      GotrueSessionResponse response = await supabase.auth.signUp(
        controller.emailController.value.text,
        controller.passwordController.value.text
      );
      
      if(response.error != null){
        showWarningToast(fToast: fToast, message: response.error!.message);
      }
      if(response.user != null){
        final informations = {
          'id': response.user!.id,
          'name': controller.nameController.value.text,
          'last_name': controller.lastNameController.value.text,
          'nickname': controller.nameController.value.text.split(" ").first,
          'birthday': toTimestampString(DateFormat('dd/MM/yyyy').parse(controller.dateController.value.text).toIso8601String()),
          'gender': controller.getGender(),
          'gender_value': controller.getGenderValue()
        };

        final resp = await supabase.from('user').upsert(informations).execute();

        if(resp.error != null){
          showWarningToast(fToast: fToast, message: response.error!.message);
        }
        if(resp.data != null){
          showWarningToast(fToast: fToast, message: 'cadastrado com sucesso, por favor verifique seu email para poder acessar');
          to(context, LoginPage());
        }
      }
    }
  }
  
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).viewInsets.bottom == 0 ? MediaQuery.of(context).size.height * 0.8 : MediaQuery.of(context).size.height * 0.5,
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(10),

                constraints: BoxConstraints(
                  maxWidth: 600,
                  maxHeight: 700
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1D27),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Form(
                  key: controller.formKey,
                  onChanged: () => controller.formKey.currentState?.validate(),
                  child: CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Insira o restante dos dados.'),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Input(
                                    controller: controller.nameController.value,
                                    type: TextInputType.name,
                                    label: const Text('Nome'),
                                    hintText: 'insira seu nome...'
                                  ),
                                  Input(
                                    controller: controller.lastNameController.value,
                                    type: TextInputType.name,
                                    label: const Text('Sobrenome'),
                                    hintText: 'insira seu sonbrenome...',
                                  ),
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
                                          Flexible(child: Container(margin: const EdgeInsets.only(left: 20), child: Input(controller: controller.genderController.value, type: TextInputType.text, label: Text('gênero'), hintText: 'Insira seu gênero...')))
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
                                Button(text: 'Confirmar', onPress: () async {await _signUp();} , size: const Size(100, 50), borderRadius: 15),
                              ],
                            )
                          ],
                        ),
                      )
                    ]
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}