import 'package:flutter/material.dart';
import '../../components/bars/BottomMenuBar.dart';

import '../../components/bars/TopMenuBar.dart';


class NotificationPage extends StatefulWidget{
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
  
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopMenuBar(height: 100, name: 'Notificações'),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            getExampleNotification(),
            getExampleNotification(),
            getExampleNotification(),
          ]
        ),
      ),
      bottomNavigationBar: BottomMenuBar(notificationIsActive: true, colorBack: Theme.of(context).backgroundColor),
    );
  }


  getExampleNotification(){
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


