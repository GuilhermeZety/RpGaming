import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/navigate.dart';
import '../../Util/toasts.dart';
import '../../api/user/user-api.dart';
import '../home/home_page.dart';


part 'change-password-viewmodel.g.dart';

class ChangePasswordViewModel = _ChangePasswordViewModel with _$ChangePasswordViewModel;

abstract class _ChangePasswordViewModel with Store {
  final formKey = GlobalKey<FormState>();

  @observable
  TextEditingController passwordController = TextEditingController();
  @action 
  void setPasswordControllerText(String _) => passwordController.text = _;


  handleResetPassword(context) async {
     if (formKey.currentState!.validate()) {
      
      var response = await UserApi().updateUser(supabase.auth.currentSession!.accessToken, UserAttributes(password: passwordController.text));
      
      if(response){
        showSuccessToast(fToast: FToast().init(context), message: 'Senha alterada com sucesso!');
        to(context, HomePage());
      }
      else{
        showWarningToast(fToast: FToast().init(context), message: 'Houve erro atualizando senha, verifique-a e tente novamente!');
      }
    }   
  }


}