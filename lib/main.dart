import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app_widget.dart';


bool resetingPassword = false;

late Supabase clientSupabase;

Future<void> main() async {  
  WidgetsFlutterBinding.ensureInitialized();

  clientSupabase = await Supabase.initialize(
    url: 'https://guumgdrnhhdgjobrkywv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd1dW1nZHJuaGhkZ2pvYnJreXd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTg3NzkwMzAsImV4cCI6MTk3NDM1NTAzMH0.lLakSow7o66hKubP7IdR2_NNGXbEGwtPgyNH7lHrkqE',
  );
  
  runApp(AppWidget());
}   