import 'dart:async';

import 'package:flutter/material.dart';

import '../../Cache.dart';
import '../../Util/NetworkInfo.dart';
import '../../Util/constants.dart';
import '../../Util/navigate.dart';
import '../../models/user-info.dart';
import '../../pages/notification/notification-page.dart';
import '../../pages/profile/profile-page.dart';
import '../logo.dart';

class UserMenuBar extends StatefulWidget {
  const UserMenuBar({Key? key}) : super(key: key);

  @override
  State<UserMenuBar> createState() => _UserMenuBarState();
}

class _UserMenuBarState extends State<UserMenuBar> {  

  UserInfo? userInfo;
  @override
  initState(){
    super.initState();

    Timer.run(() => updateUser());
  }

  @override
  void dispose() {
    super.dispose();
  }

  updateUser() async {
    if(await hasInternetConnection()){
      var currentProfile = await Cache().getUserInfo();
      
      if(currentProfile != null){
        setState(() {
          userInfo = currentProfile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = getWhatSize(context);
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(maxHeight: 70),
        height: 70,
        color: orientation == Orientation.portrait ? Color(0xFF06071A) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           orientation == Orientation.portrait ? Logo() : SizedBox(),
            Row(
              children: [
                GestureDetector(
                  onTap: () => to(context, NotificationPage()),
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,                
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () => to(context, NotificationPage()),
                          splashColor: Theme.of(context).primaryColor,
                          hoverColor: Theme.of(context).primaryColor.withOpacity(0.4),
                          icon: Icon(Icons.notifications_active),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,                
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Text('8', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).scaffoldBackgroundColor),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async => to(context, ProfilePage()),
                    child: CircleAvatar(
                      radius: 40,                   
                      child: 
                      userInfo != null ? 
                        userInfo!.avatar_url != null ? 
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(userInfo!.avatar_url!)
                          ) : 
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/no-user.png')
                        ) : 
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/no-user.png')
                      ), 
                    )
                  ),
                ),
              ],
            ),                  
          ],
        ),
      ),
    );
  }
}