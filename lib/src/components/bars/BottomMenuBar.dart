import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Util/navigate.dart';
import '../../pages/config/config-page.dart';
import '../../pages/home/home_page.dart';
import '../../pages/notification/notification-page.dart';
import '../../pages/profile/profile-page.dart';

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({Key? key, 
    this.homeIsActive = false, 
    this.notificationIsActive = false, 
    this.userIsActive = false, 
    this.gearIsActive = false, 
    this.colorBack, 
  }) : super(key: key);

  final bool homeIsActive;
  final bool notificationIsActive;
  final bool userIsActive;
  final bool gearIsActive;
  final Color? colorBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,    
      height: 60,
      color: colorBack,
      child: Stack(
        children: [          
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,    
                color: Color(0xFF06071A),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //buttom Home
                    GestureDetector(
                      onTap: !homeIsActive ? () => to(context, HomePage()) : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: homeIsActive ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(99)
                        ),
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.home, 
                          size: 28, 
                          color: homeIsActive ? Theme.of(context).primaryColor : null
                        )
                      ),
                    ),

                    //buttom notification
                    GestureDetector(
                      onTap: !notificationIsActive ? () => to(context, NotificationPage()) : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: notificationIsActive ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(99)
                        ),
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.notifications_active, 
                          size: 28, 
                          color: notificationIsActive ? Theme.of(context).primaryColor : null
                        )
                      ),
                    ),

                    SizedBox(width: 120),
                    
                    //buttom user
                    GestureDetector(
                      onTap: !userIsActive ? () => to(context, ProfilePage()) : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: userIsActive ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(99)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          FontAwesomeIcons.solidUser, 
                          size: 26, 
                          color: userIsActive ? Theme.of(context).primaryColor : null
                        )
                      ),
                    ),

                    //buttom gear
                    GestureDetector(
                      onTap: !gearIsActive ? () => to(context, ConfigPage()) : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: gearIsActive ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(99)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          FontAwesomeIcons.gear, 
                          size: 26, 
                          color: gearIsActive ? Theme.of(context).primaryColor : null
                        )
                      ),
                    ),
                    // Icon(FontAwesomeIcons.),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 50,
                    child: Icon(Icons.add),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}