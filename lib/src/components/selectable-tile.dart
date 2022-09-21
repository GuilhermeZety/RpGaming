import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Util/constants.dart';

class SelectableTile extends StatelessWidget {
  const SelectableTile({Key? key, required this.title, required this.backIcon, required this.onTap}) : super(key: key);
  
  final String title;
  final IconData backIcon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // height: 70,
          padding: EdgeInsets.all(10),
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), 
            color: isPortrait(context) ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).backgroundColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(1000)
                    ),
                    margin: EdgeInsets.only(right: 30),
                    child: Icon(backIcon, size: 24, color: Theme.of(context).primaryColor,)
                  ),
                  Text(title, style: TextStyle(
                    fontSize: 19,
                    color: Colors.grey.shade200
                  ),),
                ],
              ),
              Icon(FontAwesomeIcons.angleRight, size: 16, color: Theme.of(context).primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}