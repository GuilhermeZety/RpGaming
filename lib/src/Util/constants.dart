import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final supabase = Supabase.instance.client;
final supabaseInstanse = Supabase.instance;

Orientation getWhatSize(BuildContext c){
  return MediaQuery.of(c).orientation;
}