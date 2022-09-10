

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static final String primaryColor = 'primaryColor';

  Future setPrimaryColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result = await prefs.setInt(primaryColor, color.value);

    return result;
  }

  Future<Color?> getPrimaryColor() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var result = await prefs.getInt(primaryColor);

      if(result != null){
        return Color(result);
      }

    }
    catch(err){
      print(err);
    }
    return null;
  }
  
}