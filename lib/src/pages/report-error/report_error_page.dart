// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/Util/toasts.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/Input.dart';
import 'package:rpgaming/src/components/Logo.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';

class ReportErrorPage extends StatefulWidget {
  static const String route = '/report-error';
  const ReportErrorPage({Key? key, required this.error}) : super(key: key);

  final String error;

  @override 
  State<ReportErrorPage> createState() => _ReportErrorPageState();
}

class _ReportErrorPageState extends State<ReportErrorPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  FToast fToast = FToast();
  
  @override
  initState() {
    super.initState();
    fToast.init(context);
  }   

  _sendReport() async{
     final report = {
      'error': widget.error,
      'resume': textController.text.trim(),
      'json_session': supabase.auth.session() != null ? jsonEncode(supabase.auth.session()) : null
    };
    final response = await supabase.from('log_reports').upsert(report).execute();

    if (response.error != null) {
      showWarningToast(fToast: fToast, message: response.error!.message);
      // to(context, LoginPage());
    } else {
      //success
      showSuccessToast(fToast: fToast, message: 'Enviado Com Sucesso');
      to(context, LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Logo(),
            Container(
              constraints: BoxConstraints(
                maxWidth: 500
              ),
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
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: const Text('Por favor, insira com detalhes o que aconteceu, isso ajudará muito a fazer um aplicativo melhor para todos 😁.')
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text('Erro: ${widget.error}')
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Input(type: TextInputType.text, 
                        label: const Text('Resumo'), 
                        hintText: 'Insira aonde, quando e como aconteceu...', 
                        controller: textController, 
                        big: true
                      )
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(text: 'Voltar', onPress: () => to(context, const LoginPage()), size: const Size(100, 50), colorInverted: true, borderRadius: 15, ),
                        const SizedBox(width: 10),
                        Button(text: 'Enviar', onPress: () async  => _sendReport(), size: Size(100, 50), borderRadius: 15),
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