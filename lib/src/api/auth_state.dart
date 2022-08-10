import 'package:flutter/material.dart';
import 'package:rpgaming/main.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/models/UserInfo.dart';
import 'package:rpgaming/src/pages/forgot-password/change-password-page.dart';
import 'package:rpgaming/src/pages/home/home_page.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rpgaming/src/Util/constants.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      to(context, LoginPage());
    }
  }

  @override
  void onAuthenticated(Session session) async {
    if (mounted) {
      if(resetingPassword){
        print('reseting');
      }
      else{
        await _update(session);
      }
      context.showSuccessSnackBar(message: 'logado com sucesso');
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
    if(message == 'The resource owner or authorization server denied the request'){
      context.showWarningSnackBar(message: 'Usuário recusou a autorização');
    }
    else if(message == 'Email link is invalid or has expired'){
      context.showWarningSnackBar(message: 'Link de email inválido ou expirado');
    }
    else{
      context.showWarningSnackBar(message: message);
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
    final newUser = UserInfo(
        id: session.user!.id, 
        created_at: DateTime.parse(session.user!.createdAt),
        name: session.user!.userMetadata['full_name'],
        nickname: session.user!.userMetadata['nickname'] == null ? session.user!.userMetadata['full_name'].split(" ").first : session.user!.userMetadata['nickname'],
        last_name: session.user!.userMetadata['full_name'].split(" ").length > 1 ? session.user!.userMetadata['full_name'].split(" ").last : null,
        name_provider: 'discord', //trocar
        avatar_url: session.user!.userMetadata['avatar_url'],
        updated_at: DateTime.now()
      );

      final resp = await supabase.from('user').upsert(newUser.toMap()).execute();

      if(resp.error != null){
        context.showWarningSnackBar(message: resp.error!.message);
      }
  }

  
}