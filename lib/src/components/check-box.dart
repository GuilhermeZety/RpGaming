import 'package:flutter/material.dart';

class CheckBoxComponent extends StatelessWidget {
  const CheckBoxComponent({Key? key, this.selected, this.onChanged}) : super(key: key);

  final bool? selected;
  final void Function(bool?)? onChanged;


  onchange(bool? isTrue) {
    print('foi');

    onChanged!(isTrue);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      tristate: true,
      checkColor: Theme.of(context).scaffoldBackgroundColor,
      fillColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
            return Theme.of(context).primaryColor;
              }
            return Colors.grey;
          },
      ),                  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),                   
      value: selected ?? false,
      onChanged: onchange
    );
  }
}