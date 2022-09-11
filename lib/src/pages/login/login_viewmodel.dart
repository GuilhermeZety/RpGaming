
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Util/NetworkInfo.dart';
import '../../Util/navigate.dart';
import '../../models/ResponseModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/constants.dart';
import '../no-signal/no-signal-page.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  var emailController = ValueNotifier<TextEditingController>(TextEditingController());
  var passwordController = ValueNotifier<TextEditingController>(TextEditingController());

  onLoad(context) async {
    if(!await hasInternetConnection()){
      to(context, NoSignalPage());
    }
  }


  Future<ResponseModel?> signIn(Provider? provider) async {
    if (provider == null) {
      if(formKey.currentState!.validate()){
        try{
          GotrueSessionResponse res = await supabase.auth.signIn(
            email: emailController.value.text,
            password: passwordController.value.text
          );
          if(res.error != null){
            if(res.error!.message == 'Invalid login credentials'){
              return ResponseModel(
                isWarning: true,
                message: 'Email ou senha inválidos'
              );
            }
            else if(res.error!.message == "Email not confirmed"){
              return ResponseModel(
                isWarning: true,
                message: 'Email não confirmado'
              );
            }
            else{
              return ResponseModel(
                isWarning: true,
                message: res.error!.message
              );
            }
          }
          else{
            if(res.data != null){
              return ResponseModel(
                success: true,
                message: 'Logado com sucesso'
              );
            }
          }          
        }
        catch(err){
          return ResponseModel(
            isError: true,
            message: err.toString()
          );
        }
      }
    }    
    else{
      try{
        var redirect =  kIsWeb ? 'http://localhost:5000/' : 'io.supabase.flutterquickstart://login-callback/';
        final res = await supabase.auth.signInWithProvider(
          provider,        
          options: AuthOptions(
            redirectTo: redirect
          ),
        );
        
        if(res == false){
           return ResponseModel(
            isWarning: true,
            message: 'Não houve sucesso ao logar com o ${provider.name()}'
          );
        }
      }
      catch(err){
        return ResponseModel(
          isError: true,
          message: err.toString()
        );
      }
    }
    return null;
  }  
}
