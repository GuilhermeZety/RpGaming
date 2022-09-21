import 'package:flutter/material.dart';

import '../bars/top-menu-bar.dart';
import '../bars/user-menu-bar.dart';


class LandscapePageModel extends StatefulWidget {
  LandscapePageModel({Key? key, 
    required this.child, 
    this.navbar, 
    this.showUserMenuBar = true, 
    this.showTopMenuBar = true, 
    this.topMenuName, 
    this.topMenuBackPage,
    this.topMenuColor,
  }) : super(key: key);

 final Widget child;
 final Widget? navbar;
 final bool showUserMenuBar;
 final bool showTopMenuBar;
 final String? topMenuName;
 final Widget? topMenuBackPage;
 final Color? topMenuColor;

  @override
  State<LandscapePageModel> createState() => _LandscapePageModelState();
}

class _LandscapePageModelState extends State<LandscapePageModel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.navbar ?? SizedBox(),
        Container(
          width: MediaQuery.of(context).size.width - 300,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 0),
          child: Column(
            children: [
              widget.showUserMenuBar ? UserMenuBar() : SizedBox(),
              Center(
                child: Container(
                  width: 650,
                  height: MediaQuery.of(context).size.height - 90,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                  ),
                  child: 
                  Column(
                    children: [
                      Container(
                        width: 650,
                        height: 100,
                        margin: EdgeInsets.only(bottom: 40,),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                        ),
                        child: widget.showTopMenuBar ?
                        TopMenuBar(
                          height: 100, 
                          name: widget.topMenuName ?? '',
                          backPage: widget.topMenuBackPage,
                          backgroundColor: widget.topMenuColor,
                        ).getWidget(context)
                        : SizedBox()
                      ),                        
                      widget.child
                    ]
                  )
                )
              )
            ]
          )
        )
      ]
    );
  }
}