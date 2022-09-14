import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpgaming/src/pages/config/config-page.dart';
import 'package:rpgaming/src/pages/profile/profile-page.dart';
import '../../../Util/constants.dart';
import '../../DividerWithWidget.dart';
import '../../Logo.dart';

import '../../../Util/navigate.dart';
import '../../../pages/home/home_page.dart';
import '../../../pages/notification/notification-page.dart';
import 'NavbarItem.dart';


class Navbar extends StatefulWidget {
  Navbar({Key? key, 
    this.homeIsActive = false, 
    this.notificationIsActive = false, 
    this.userIsActive = false, 
    this.gearIsActive = false,
  }) : super(key: key);
  
  final bool homeIsActive;
  final bool notificationIsActive;
  final bool userIsActive;
  final bool gearIsActive;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    
    loggout(){
      supabase.auth.signOut();
    }
    
    return Container(
      width: 300,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Logo(),
              SizedBox(height: 60),
              NavbarItem(
                content: 'Home',
                icon: Icons.home,
                isActive: widget.homeIsActive,
                onTap: !widget.homeIsActive ? () => to(context, HomePage()) : null,
              ),
              SizedBox(height: 15),
              NavbarItem(
                content: 'Notificações',
                icon: Icons.notifications_on_rounded,
                suffix: getNotificationSuffix(),
                isActive: widget.notificationIsActive,
                onTap: !widget.notificationIsActive ? () => to(context, NotificationPage()) : null,
              ),
              SizedBox(height: 15),
              NavbarItem(
                content: 'Usuário',
                icon: FontAwesomeIcons.solidUser,
                isActive: widget.userIsActive,
                onTap: !widget.userIsActive ? () => to(context, ProfilePage()) : null,
              ),
            ],
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DividerWithWidget(),
              SizedBox(height: 20),
              NavbarItem(
                content: 'Configurações',
                icon: FontAwesomeIcons.gear,
                isActive: widget.gearIsActive,
                onTap: !widget.gearIsActive ? () => to(context, ConfigPage()) : null,
              ),
              NavbarItem(
                content: 'Sair',
                icon: Icons.logout,
                isActive: false,
                onTap: () => loggout(),
              ),
              
            ],
          ),
        ],
      ),
    );
  }

  getNotificationSuffix(){
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,                
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(child: Text('8', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).scaffoldBackgroundColor),)),
    );
  }
  
}
