// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/components/button.dart';
import 'package:rpgaming/src/components/date-time-picker.dart';
import 'package:rpgaming/src/components/input.dart';
import 'package:rpgaming/src/enums/gender_person.dart';
import 'package:rpgaming/src/pages/create-account/create-account-viewmodel.dart';
import 'package:rpgaming/src/pages/login/login-page.dart';


class ContinueCreateAccountPage extends StatefulWidget {
  static const String route = '/continue-create-account';

  const ContinueCreateAccountPage({Key? key,  this.controller}) : super(key: key);

  final CreateAccountViewModel? controller;

  @override
  State<ContinueCreateAccountPage> createState() => _ContinueCreateAccountPageState();
}

class _ContinueCreateAccountPageState extends State<ContinueCreateAccountPage> {
  var controller = CreateAccountViewModel();
  
  @override
  initState() {
    super.initState();
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
        child: Observer(
           builder: (_) => Center(
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
                                      controller: controller.nameController,
                                      type: TextInputType.name,
                                      label: const Text('Nome'),
                                      hintText: 'insira seu nome...'
                                    ),
                                    Input(
                                      controller: controller.lastNameController,
                                      type: TextInputType.name,
                                      label: const Text('Sobrenome'),
                                      hintText: 'insira seu sonbrenome...',
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
                                    InputDateTime(dateController: controller.dateController, label: 'Data de nascimento', onchange: () => controller.formKey.currentState?.validate()),
                                                              
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 75,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 70,
                                                padding: EdgeInsets.only(bottom: 14),
                                                child: DropdownButton<GenderPerson>(
                                                  itemHeight: 50,
                                                  dropdownColor: const Color(0xFF2F2F3C),
                                                  value: controller.genderPerson,
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
                                                  onChanged: (value) => controller.setGenderPerson(value!)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        controller.genderPerson == GenderPerson.other ?
                                          Flexible(child: Container(margin: const EdgeInsets.only(left: 20), child: Input(controller: controller.genderController, type: TextInputType.text, label: Text('g??nero'), hintText: 'Insira seu g??nero...')))
                                        : const SizedBox()
                                      ],
                                    ),
                                  ],
                                )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Button(text: 'Voltar', onPress: () => to(context, const LoginPage()), size: const Size(100, 50), colorInverted: true, borderRadius: 15, ),
                                  const SizedBox(width: 10),
                                  Button(text: 'Confirmar', onPress: () async {await controller.signUp(context);} , size: const Size(100, 50), borderRadius: 15),
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
      ),
    );    
  }
}