import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Util/navigate.dart';
import '../../pages/home/home_page.dart';

class TopMenuBar extends StatelessWidget with PreferredSizeWidget{
  const TopMenuBar({Key? key, this.backPage, required this.height, required this.name, this.backgroundColor }) : super(key: key);
  
  final double height;
  final Widget? backPage;
  final String name;
  final Color? backgroundColor;


  @override
  Size get preferredSize => Size.fromHeight(height);

  getWidget(context){
    return Container(
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 10),
              IconButton(
                onPressed: () => to(context, backPage ?? HomePage()),
                icon:Icon(FontAwesomeIcons.arrowLeft, size: 20, color: Theme.of(context).secondaryHeaderColor,)
              ),
              SizedBox(width: 10),
              Text('Voltar', style: TextStyle(color: Theme.of(context).secondaryHeaderColor,),)
            ],
          ),
          Row(
            children: [
              SizedBox(width: 15),
              Container(
                height: 48.0,
                alignment: Alignment.center,
                child: Text(name, style: TextStyle(fontSize: 28, color: Color(0xFFD8D8D8)),),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      elevation: 0,
      leadingWidth: MediaQuery.of(context).size.width,
      leading: GestureDetector(
        onTap: () => to(context, backPage ?? HomePage()),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 10),
            IconButton(
              onPressed: () => to(context, backPage ?? HomePage()),
              icon:Icon(FontAwesomeIcons.arrowLeft, size: 20, color: Theme.of(context).secondaryHeaderColor,)
            ),
            SizedBox(width: 10),
            Text('Voltar', style: TextStyle(color: Theme.of(context).secondaryHeaderColor,),)
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: Row(
          children: [
            SizedBox(width: 15),
            Container(
              height: 48.0,
              alignment: Alignment.center,
              child: Text(name, style: TextStyle(fontSize: 28, color: Color(0xFFD8D8D8)),),
            ),
          ],
        ),
      )
    );
  }
}