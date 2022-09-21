import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../home/home_page.dart';

import '../../Util/constants.dart';
import '../../api/auth_required_state.dart';
import '../../components/bars/bottom-menu-bar.dart';
import '../../components/bars/navbar/navbar.dart';
import '../../components/bars/top-menu-bar.dart';
import '../../components/cards/notification-cart.dart';
import '../../components/model/landscape-page-model.dart';
import '../../components/skeleton.dart';


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
          child: Observer(
            builder: (_) =>         
              getContentBasedInOrientation()
          )
        ),
        bottomNavigationBar: isPortrait(context) ? BottomMenuBar(notificationIsActive: true, colorBack: Theme.of(context).backgroundColor) : null,
      ),
    );
  }  
  
  getContentBasedInOrientation(){    
    if(isLandscape(context)){
      return LandscapePageModel(        
        navbar: Navbar(notificationIsActive: true),
        topMenuName: "Notificações",
        topMenuBackPage: HomePage(),
        topMenuColor: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
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
                  borderRadius: 10,
                  sizeSkeleton: NotificationCard.getSkeleton(getWhatSize(context)),
                  child: listNotifications[index],
                ),
              );
            }
          ),
        ),
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
              borderRadius: 10,
              sizeSkeleton: NotificationCard.getSkeleton(getWhatSize(context)),
              child: listNotifications[index],
            ),
          );
        }
      )
    );
  }
}
