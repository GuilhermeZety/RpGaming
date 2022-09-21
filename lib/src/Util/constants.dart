import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final supabase = Supabase.instance.client;
final supabaseInstanse = Supabase.instance;

Orientation getWhatSize(BuildContext c){
  return MediaQuery.of(c).orientation;
}

isPortrait(BuildContext c){
  return MediaQuery.of(c).orientation == Orientation.portrait;
}

isLandscape(BuildContext c){
  return MediaQuery.of(c).orientation == Orientation.landscape;
}

List<Map<String, dynamic>> themePrimaryColors = [
  {
    'color': Color(0xFF666CDE),
    'name': 'Lilás'
  },
  {
    'color': Color(0xFF7A1AC6),
    'name': 'Roxo'
  },
  {
    'color': Color(0xFF3FD9C6),
    'name': 'Ciano'
  },
  {
    'color': Color(0xFFC3C33C),
    'name': 'Amarelo'
  }
];