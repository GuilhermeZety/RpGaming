import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/NetworkInfo.dart';
import '../../Util/constants.dart';
import '../../api/auth_required_state.dart';
import '../../components/bars/bottom-menu-bar.dart';
import '../../components/bars/navbar/navbar.dart';
import '../../components/bars/user-menu-bar.dart';
import '../../components/skeleton.dart';
import '../../models/user-info.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends AuthRequiredState<HomePage> { 
  var _loading = true;

  User? sessionUser;
  UserInfo? userInfo;

  bool hasInternet = false;
  
  FToast fToast = FToast();
  
  List<Widget> listPersonas = [
    PersonaCard(),
    PersonaCard(),
    PersonaCard(),
    PersonaCard(),
  ];

  List<Widget> listSessoes = [
    SessoesCard(),
    SessoesCard(),
    SessoesCard(),
  ];

  @override
  initState() {
    super.initState();
    fToast.init(context);
    Timer.run(() => onLoad());
  }   

  onLoad() async {
    hasInternet = await hasInternetConnection();
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
        child: getContentBasedInOrientation()
      ),
      bottomNavigationBar: isPortrait(context) ? BottomMenuBar(homeIsActive: true, colorBack: Theme.of(context).backgroundColor) : null,
    );
  }

  getContentBasedInOrientation(){
    
    if(isLandscape(context)){
      return Row(
        children: [
          Navbar(homeIsActive: true),
          Container(
            width: MediaQuery.of(context).size.width - 300,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                  UserMenuBar(),
                  //title Personas
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text('Seus Personagens', style: TextStyle(fontSize: 30)),
                  ),
                  //lista Personas
                  Container(
                    width: MediaQuery.of(context).size.width - 480,
                    height: 360,     
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listPersonas.length,
                      shrinkWrap: true,                      
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Skeleton(
                            borderRadius: 10,
                            isLoading: _loading,
                            sizeSkeleton: PersonaCard.getSkeleton(getWhatSize(context)),
                            child: listPersonas[index],
                          ),
                        );
                      }
                    ),
                  ),

                  //title Sessions
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 30),
                    child: Text('Suas Sessões', style: TextStyle(fontSize: 30)),
                  ),
                  //lista Sessions
                  Container(
                    width: MediaQuery.of(context).size.width - 480,
                    height: 360,     
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listSessoes.length,
                      shrinkWrap: true,                      
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Skeleton(
                            borderRadius: 10,
                            isLoading: _loading,
                            sizeSkeleton: SessoesCard.getSkeleton(getWhatSize(context)),
                            child: listSessoes[index],
                          ),
                        );                        
                      }
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    return Column(
      children: [        
        //topMenu      
        UserMenuBar(),            
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
                    //title Personas
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text('Seus Personagens', style: TextStyle(fontSize: 24)),
                    ),
                    //lista Personas
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 240,     
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listPersonas.length,
                        shrinkWrap: true,                      
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Skeleton(
                              isLoading: _loading,
                              borderRadius: 10,
                              sizeSkeleton: PersonaCard.getSkeleton(getWhatSize(context)),
                              child: listPersonas[index],
                            ),
                          );                          
                        }
                      ),
                    ),
                    
                    //title Sessions
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 30),
                      child: Text('Suas Sessões', style: TextStyle(fontSize: 30)),
                    ),
                    ElevatedButton(onPressed: () => supabase.auth.signOut(), child: Text('sair')),
                    //lista Personas
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 240,     
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listSessoes.length,
                        shrinkWrap: true,                      
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Skeleton(
                              isLoading: _loading,
                              borderRadius: 10,
                              sizeSkeleton: SessoesCard.getSkeleton(getWhatSize(context)),
                              child: listSessoes[index],
                            ),
                          );                          
                        }
                      ),
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

class PersonaCard extends StatelessWidget {
  const PersonaCard({Key? key}) : super(key: key);

  static Size getSkeleton(Orientation orientation){
    return Size(orientation == Orientation.portrait ? 200 : 260, orientation == Orientation.portrait ? 240 : 360);
    
    // Container(
    //   height: ,
    //   width: ,
    //   decoration: BoxDecoration(
    //     color: Colors.black,
    //     borderRadius: BorderRadius.circular(10)
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isPortrait(context) ? 240 : 360,
      width: isPortrait(context) ? 200 : 260,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}

class SessoesCard extends StatelessWidget {
  const SessoesCard({Key? key}) : super(key: key);

  static getSkeleton(Orientation orientation){
    return Size(orientation == Orientation.portrait ? 300 : 460, orientation == Orientation.portrait ? 240 : 360);
    
    // Container(
    //   height: orientation == Orientation.portrait ? 240 : 360,
    //   width: orientation == Orientation.portrait ? 300 : 460,
    //   decoration: BoxDecoration(
    //     color: Colors.black,
    //     borderRadius: BorderRadius.circular(10)
    //   ),
    // );
  }

 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isPortrait(context) ? 240 : 360,
      width: isPortrait(context) ? 300 : 460,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}