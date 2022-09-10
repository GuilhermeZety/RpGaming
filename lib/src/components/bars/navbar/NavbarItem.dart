import 'package:flutter/material.dart';

class NavbarItem extends StatelessWidget {
  const NavbarItem({
    Key? key,
    required this.icon,
    required this.content,
    this.suffix,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);
  
  final IconData icon;
  final String content;
  final Widget? suffix;
  final bool isActive;
  final void Function()? onTap;



  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor.withOpacity(0.15) : null,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: isActive ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Icon(icon, color: isActive ? Theme.of(context).primaryColor : Theme.of(context).textTheme.headline1!.color,)
                  ),
                  SizedBox(width: 30),
                  Container(
                    child: Text(content, style: TextStyle(color: isActive ? Theme.of(context).primaryColor : null),)
                  ),
                ],
              ),

              suffix ?? SizedBox(width: 10,)
            ],
          ),
        ),
      ),
    );
  }
}