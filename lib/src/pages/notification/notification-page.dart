import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../../Util/constants.dart';
import '../../api/auth_required_state.dart';
import '../../components/bars/BottomMenuBar.dart';

import '../../components/bars/TopMenuBar.dart';
import '../../components/bars/UserMenuBar.dart';
import '../../components/bars/navbar/Navbar.dart';


class NotificationPage extends StatefulWidget{
  static const String route = '/notifications';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();  
}

class _NotificationPageState extends AuthRequiredState<NotificationPage> {

  List<Widget> listNotifications = [
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),

    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
    NotificationCard(),
  ];

  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: isPortrait(context) ? TopMenuBar(height: 100, name: 'Notificações') : null,
        body: Container(
          color: Theme.of(context).backgroundColor,
          width: MediaQuery.of(context).size.width,
          child: getContentBasedInOrientation()
        ),
        bottomNavigationBar: isPortrait(context) ? BottomMenuBar(notificationIsActive: true, colorBack: Theme.of(context).backgroundColor) : null,
      ),
    );
  }


  getContentBasedInOrientation(){    
    if(isLandscape(context)){
      return Row(
        children: [
          Navbar(notificationIsActive: true),
          Container(
            width: MediaQuery.of(context).size.width - 300,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 0),
            child: Column(
              children: [
                UserMenuBar(),
                Center(
                  child: Container(
                    width: 650,
                    height: MediaQuery.of(context).size.height - 90,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 650,
                          height: 100,
                          margin: EdgeInsets.only(bottom: 40,),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                          ),
                          child: TopMenuBar(
                            height: 100, 
                            name: 'Notificações',
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          ).getWidget(context)
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 270,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: listNotifications.length,
                            shrinkWrap: true,                      
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Skeleton(
                                  isLoading: _loading,
                                  skeleton: NotificationCard.getSkeleton(getWhatSize(context)),
                                  child: listNotifications[index],
                                ),
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
            )
          )
        ],
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listNotifications.length,
        shrinkWrap: true,                      
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Skeleton(
              isLoading: _loading,
              skeleton: NotificationCard.getSkeleton(getWhatSize(context)),
              child: listNotifications[index],
            ),
          );
        }
      )
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key}) : super(key: key);

  
  static getSkeleton(Orientation orientation){
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
        children: [
          Container(
            width: 70, 
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5)
            ),
          )
        ]
      ),
    );
  }
}
