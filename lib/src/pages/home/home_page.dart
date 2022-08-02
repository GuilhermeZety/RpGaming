import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:rpgaming/src/api/auth_required_state.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends AuthRequiredState<HomePage> {
  
  // final _usernameController = TextEditingController();
  // final _websiteController = TextEditingController();
  // var _loading = false;

  late User user;
  late Map userData;

  // @override
  // void initState() {
  //   super.initState();

  //   // recoverSupabaseSession();
  //   Timer.run(() => load());
  // }

  // load() async {
  // }

  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    if (response.error != null) {
      context.showWarningSnackBar(message: response.error!.message);
    }
    else{   
      //success   
      context.showSuccessSnackBar(message: 'deslogado com sucesso.');
    }
  }

  @override
  void onAuthenticated(Session session) async {
    user = session.user!;
    final profile = await _getProfile(user.id);

    setState(() {
      userData = profile;
    });

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
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            GestureDetector(
              onTap: () async {await selectImage();},
              child: CircleAvatar(radius: 40)
            ),
            Text(userData['nickname']),
            Text(userData['gender_value']),
            Text(user.email!),
            const SizedBox(height: 18),
            ElevatedButton(onPressed: _signOut, child: const Text('Sign Out')),
          ],
        ),
      ),
    );
  }
}