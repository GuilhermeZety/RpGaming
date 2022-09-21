import 'package:flutter/material.dart';

import '../../Util/constants.dart';
import '../check-box.dart';

class SeletableCheckboxCard extends StatelessWidget {
  const SeletableCheckboxCard({Key? key, 
    this.color = Colors.black, 
    required this.name, 
    this.isPersonalized, 
    this.imagePath, 
    this.onClick
  }) : super(key: key);
  
  final Color color;
  final String? imagePath;
  final String name;
  final bool? isPersonalized;
  final void Function()? onClick;

  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onClick,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: isPortrait(context) ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 30,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: imagePath == null ? color : null,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: imagePath != null ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(imagePath!, fit: BoxFit.cover)
                          ) : null,
                        ),
                        Text(name)
                      ],
                    ),
                    GestureDetector(
                      onTap: onClick,
                      child: Transform.scale(
                        scale: 1.3,
                        child: CheckBoxComponent(
                          selected: isPersonalized ?? color == Theme.of(context).primaryColor,
                          onChanged: (_) => onClick
                        ),
                      ),
                    )                
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
