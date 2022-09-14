

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/UserInfo.dart';

class Cache {
  static final String primaryColor = 'primaryColor';
  static final String userInfo = 'userInfo';

  Future<bool> setPrimaryColor(Color color) async {
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

  Future<bool> setUserInfo(UserInfo infoUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result = await prefs.setString(userInfo, infoUser.toJson());

    return result;
  }

  Future<UserInfo?> getUserInfo() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var result = await prefs.getString(userInfo);

      if(result != null){
        return UserInfo.fromJson(result);
      }
    }
    catch(err){
      print(err);
    }
    return null;
  }
  
}