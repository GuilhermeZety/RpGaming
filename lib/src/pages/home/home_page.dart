import 'dart:async';

import 'package:flutter/material.dart';
import '../../components/bars/BottomMenuBar.dart';
import '../../Util/NetworkInfo.dart';
import '../../components/bars/navbar/Navbar.dart';
import '../../components/bars/UserMenuBar.dart';
import '../../models/UserInfo.dart';
import '../../api/auth_required_state.dart';
import '../../Util/constants.dart';
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

  bool hasInternet = false;

  @override
  initState() {
    super.initState();
    Timer.run(() => onLoad());
  }   

  onLoad() async {
    hasInternet = await hasInternetConnection();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(        
        child: 
        _loading ?
          Center(child: CircularProgressIndicator( color: Theme.of(context).primaryColor,))
        :
        getContentBasedInOrientation()
        
      ),
      bottomNavigationBar: getWhatSize(context) == Orientation.portrait ? BottomMenuBar(homeIsActive: true, colorBack: Theme.of(context).backgroundColor) : null,
    );
  }

  getContentBasedInOrientation(){
    
    if(getWhatSize(context) == Orientation.landscape){
      return Row(
        children: [
          Navbar(homeIsActive: true,)
        ],
      );
    }

    return Column(
          children: [        
            //topMenu      
            UserMenuBar(userInfo: userInfo),            
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                padding: EdgeInsets.only(right: 15, left: 15, top: 20),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(                                 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          color: Colors.grey.withOpacity(0.2),
                          width: 140,
                          height: 20,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              color: Colors.grey.withOpacity(0.2),
                              width: 180,
                              height: 200,
                            ),
                            SizedBox(width: 10),
                            Container(
                              color: Colors.grey.withOpacity(0.2),
                              width: 170,
                              height: 200,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: Colors.grey.withOpacity(0.2),
                          width: 140,
                          height: 20,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              color: Colors.grey.withOpacity(0.2),
                              width: 180,
                              height: 200,
                            ),
                            SizedBox(width: 10),
                            Container(
                              color: Colors.grey.withOpacity(0.2),
                              width: 170,
                              height: 200,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: Colors.grey.withOpacity(0.2),
                          width: 100,
                          height: 20,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              color: Colors.grey.withOpacity(0.2),
                              width: 280,
                              height: 200,
                            ),
                            SizedBox(width: 10),
                            Container(
                              color: Colors.grey.withOpacity(0.2),
                              width: 70,
                              height: 200,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}