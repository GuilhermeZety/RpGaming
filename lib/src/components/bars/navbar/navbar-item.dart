import 'package:flutter/material.dart';

class NavbarItem extends StatefulWidget {
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
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  @override
  Widget build(BuildContext context) {
    Color colorContainer = Theme.of(context).primaryColor.withOpacity(0.15);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.isActive ?  colorContainer : null,
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
                      color: widget.isActive ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Icon(widget.icon, color: widget.isActive ? Theme.of(context).primaryColor : Theme.of(context).textTheme.headline1!.color,)
                  ),
                  SizedBox(width: 30),
                  Container(
                    child: Text(widget.content, style: TextStyle(color: widget.isActive ? Theme.of(context).primaryColor : null),)
                  ),
                ],
              ),

              widget.suffix ?? SizedBox(width: 10,)
            ],
          ),
        ),
      ),
    );
  }
}