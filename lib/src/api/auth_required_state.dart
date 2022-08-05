import 'package:flutter/material.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  @override
  void onUnauthenticated() {
    to(context, LoginPage());
  }
}