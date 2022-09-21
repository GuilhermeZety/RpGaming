
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/NetworkInfo.dart';
import '../../Util/constants.dart';
import '../../Util/navigate.dart';
import '../../Util/toasts.dart';
import '../../models/response-model.dart';
import '../home/home_page.dart';
import '../no-signal/no-signal-page.dart';

part 'login-viewmodel.g.dart';

class LoginViewModel = _LoginViewModel with _$LoginViewModel;

abstract class _LoginViewModel with Store {
  final formKey = GlobalKey<FormState>();

  @observable
  TextEditingController emailController = TextEditingController();
  @action 
  void setEmailControllerText(String _) => emailController.text = _;

  @observable
  TextEditingController passwordController = TextEditingController();
  @action 
  void setPasswordControllerText(String _) => passwordController.text = _;

  onLoad(context) async {
    if(!await hasInternetConnection()){
      to(context, NoSignalPage());
    }
  }

  handleSignIn(BuildContext context, Provider? provider) async {
    ResponseModel? response = await signIn(provider);
    
    if(response != null){
      if(response.success){
        showSuccessToast(
          fToast: FToast().init(context),
          message: response.message,
        ); 
        to(context, HomePage());
      }
      else if(response.isWarning){
        showWarningToast(
          fToast: FToast().init(context),
          message: response.message,
        ); 
      }
      else {
        showErrorToast(
          fToast: FToast().init(context),
          error: response.message,
        ); 
      }
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
        // var redirect =  kIsWeb ? 'https://guilhermezety.github.io/' : 'io.supabase.flutterquickstart://login-callback/';
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
