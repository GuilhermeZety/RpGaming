import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rpgaming/src/models/UserInfo.dart';
import 'package:rpgaming/src/api/auth_required_state.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends AuthRequiredState<HomePage> { 
  var _loading = true;

  User? sessionUser;
  UserInfo? userInfo;

  Future<void> _signOut() async {
    if(mounted){
      try{
        var response = await supabase.auth.signOut();

        if(response.error != null){
          context.showWarningSnackBar(message: response.error!.message);
        }
        else{
          context.showSuccessSnackBar(message: 'Deslogado com sucesso');
        }
      }
      catch(err){
        context.showErrorSnackBar(error: err.toString());
      }
    }
  }

  @override
  void onAuthenticated(Session session) async {
    try{
      if(session.user != null){
        if(userInfo == null){
          var a = await _getProfile(session.user!.id);
          if(a != null){
            var profile = UserInfo.fromMap(a);


            setState(() {
              sessionUser = session.user!;
              userInfo = profile;
            });
          }
        }
      }
      else{
        onUnauthenticated();
      }
      setState(() {
        _loading = false;      
      });
    }
    catch(err){
      context.showWarningSnackBar(message: err.toString());
      
      setState(() {
        _loading = false;      
      });
    }    
  }

  _getProfile(String id) async {
    final response = await supabase
        .from('user')
        .select()
        .eq('id', id)
        .single()
        .execute();
        
    if (response.error != null) {
      context.showWarningSnackBar(message: response.error!.message);
      return null;
    }

    return response.data;
  }

  @override
  void dispose() {
    super.dispose();
  }

  selectImage() async {
    // final ImagePicker _picker = ImagePicker();

    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
        _loading ?
          Center(child: CircularProgressIndicator(),)
        :
        ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            GestureDetector(
              onTap: () async {await selectImage();},
              child: CircleAvatar(radius: 40, child: userInfo != null ? userInfo!.avatar_url != null ? ClipOval(child: Image.network(userInfo!.avatar_url!)) : null : null, )
            ),
            // Text(userInfo!.nickname!),
            Text(sessionUser?.email ?? 'email'),
            // Text(userInfo!.updated_at.toIso8601String()),
            const SizedBox(height: 18),
            ElevatedButton(onPressed: () async {await _signOut();} , child: const Text('Sign Out')),
          ],
        ),
      ),
    );
  }
}