import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';
import '../Cache.dart';
import '../Util/constants.dart';
import '../Util/generator.dart';
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

  @override
  void onAuthenticated(Session session) async {
    fToast.init(context);
    if (mounted) {
      if(resetingPassword){
        print('reseting');
      }
      else{
        await verifySession(session);
      }

      to(context, HomePage());
    }
  }

  verifySession(Session session) async {
    var response = await supabase.from('user').select('updated_at').eq('id', session.user!.id).execute();

    if(response.data.length == 0){
        await _insertUser(session);
    }
    else{
      DateTime updated = DateTime.parse(response.data[0]['updated_at']);

      var user = await Cache().getUserInfo();

      if(user != null){
        if(user.updated_at != updated){
          if(user.updated_at.isAfter(updated)){
            await _updateUser(session, appIsChanged: true);
          }
          else{
            await _updateUser(session, appIsChanged: true);
          }
        }
      }
      else{        
        var result = await supabase.from('user').select().eq('id', session.user!.id).execute();

        if(result.data.length == 0){
          _insertUser(session);
        }
        else{
          Cache().setUserInfo(UserInfo.fromMap(result.data.first));
        }        
      }
    }
  }

  _updateUser(Session session, {appIsChanged = false}) async {
    fToast.init(context);

    if(appIsChanged){
      var user = await Cache().getUserInfo();

      if(user != null){
        var response = await supabase.from('user').upsert(user.toMap()).execute();
        
        if(response.error != null){
          showWarningToast(fToast: fToast, message: response.error!.message);
        }
      }
      else{
        showWarningToast(message: 'Erro atualizando infos Usuário: usuário local não encontrado', fToast: fToast);
      }
    }
    else{
      var result = await supabase.from('user').select().eq('id', session.user!.id).execute();

      if(result.data.length == 0){
        _insertUser(session);
      }
      else{
        Cache().setUserInfo(UserInfo.fromMap(result.data.first));
      }
    }
  }

  Future<String> verifyedAccountId() async {
    fToast.init(context);
    // ignore: unused_local_variable
    bool success = false;
    String actual_id;

    do
    {
      actual_id = generateAccountId();
      var resp = await supabase.from('user').select().eq('account_id', actual_id).execute();

      if(resp.error != null){
        showWarningToast(message: 'erro verificando id da conta', fToast: fToast);
      }

      if(resp.data.length == 0){
        success = true;
      }
    }while(success = false);

    return actual_id;
  }

  _insertUser(Session session) async {
    fToast.init(context);

    final newUser = UserInfo(
      id: session.user!.id, 
      account_id: await verifyedAccountId(),
      created_at: DateTime.parse(session.user!.createdAt),
      name: session.user!.userMetadata['nickname'] == null ? session.user!.userMetadata['full_name'].split(" ").first : session.user!.userMetadata['nickname'],
      nickname: session.user!.userMetadata['full_name'],
      last_name: session.user!.userMetadata['full_name'].split(" ").length > 1 ? session.user!.userMetadata['full_name'].split(" ").last : null,
      name_provider: session.user!.appMetadata['provider'], //trocar
      avatar_url: session.user!.userMetadata['avatar_url'],
      updated_at: DateTime.now()
    );

    final resp = await supabase.from('user').upsert(newUser.toMap()).execute();

    var rCache = await Cache().setUserInfo(newUser);

    if(rCache == false){
      print('erro inserindo userInfo no cache');
    }

    if(resp.error != null){
      showWarningToast(fToast: fToast, message: resp.error!.message);
    }
  }
  
}