import 'package:flutter/material.dart';
import '../Logo.dart';

import '../../Util/navigate.dart';
import '../../models/UserInfo.dart';
import '../../pages/notification/notification-page.dart';

class UserMenuBar extends StatelessWidget {
  const UserMenuBar({Key? key, required this.userInfo}) : super(key: key);

  final UserInfo? userInfo;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(maxHeight: 70),
      color: Color(0xFF06071A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Logo(),
          Row(
            children: [
              IconButton(
                onPressed: () => to(context, NotificationPage()),
                icon: Icon(Icons.notifications_active)
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () async => {},
                child: CircleAvatar(radius: 20, child: userInfo != null ? userInfo!.avatar_url != null ? ClipOval(child: Image.network(userInfo!.avatar_url!)) : null : null, )
              ),
            ],
          ),                  
        ],
      ),
    );
  }
}