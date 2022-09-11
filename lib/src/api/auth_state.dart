import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';
import '../Util/constants.dart';
import '../Util/navigate.dart';
import '../Util/toasts.dart';
import '../models/UserInfo.dart';
import '../pages/forgot-password/change-password-page.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  FToast fToast = FToast();

  @override
  void onUnauthenticated() {
    if (mounted) {
      to(context, LoginPage());
    }
  }

  @override
  void onAuthenticated(Session session) async {
    fToast.init(context);

    if (mounted) {
      if(resetingPassword){
        print('reseting');
      }
      else{
        await _update(session);
      }
      showSuccessToast(fToast: fToast, message: 'logado com sucesso');
      to(context, HomePage());
      // pushNamed(context, HomePage.route);
    }
  }

  @override
  void onPasswordRecovery(Session session) async  {
    setState(() {
      resetingPassword = true;
    });
    to(context, ChangePasswordPage());
  }

  @override
  void onErrorAuthenticating(String message) {
    fToast.init(context);

    if(message == 'The resource owner or authorization server denied the request'){
      showWarningToast(fToast: fToast, message: 'Usuário recusou a autorização');
    }
    else if(message == 'Email link is invalid or has expired'){
      showWarningToast(fToast: fToast, message: 'Link de email inválido ou expirado');
    }
    else if(message == 'Internal server error'){
      // context.showWarningSnackBar(message: 'Link de email inválido ou expirado');
    }
    else{
      // context.showWarningSnackBar(message: message);
    }
  }

  _update(Session session) async {
    var response = await supabase.from('user').select('updated_at').eq('id', session.user!.id).execute();

    if(response.error == null){
      if(response.data.length < 1){
        await _updateUser(session);
      }
      else{
        DateTime updated = DateTime.parse(response.data[0]['updated_at']);
        
        if(updated.difference(DateTime.now()).inDays > 3){
          await _updateUser(session);
        }
      }
    }
  }

  _updateUser(Session session) async {
    fToast.init(context);

    final newUser = UserInfo(
        id: session.user!.id, 
        created_at: DateTime.parse(session.user!.createdAt),
        name: session.user!.userMetadata['full_name'],
        nickname: session.user!.userMetadata['nickname'] == null ? session.user!.userMetadata['full_name'].split(" ").first : session.user!.userMetadata['nickname'],
        last_name: session.user!.userMetadata['full_name'].split(" ").length > 1 ? session.user!.userMetadata['full_name'].split(" ").last : null,
        name_provider: session.providerToken, //trocar
        avatar_url: session.user!.userMetadata['avatar_url'],
        updated_at: DateTime.now()
      );

      final resp = await supabase.from('user').upsert(newUser.toMap()).execute();

      if(resp.error != null){
        showWarningToast(fToast: fToast, message: resp.error!.message);
      }
  }
  
}