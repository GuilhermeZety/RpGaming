
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mobx/mobx.dart';

import '../../../Util/constants.dart';
import '../../../app_widget.dart';
import '../../../components/Button.dart';

part 'theme-config-viewmodel.g.dart';

class ThemeConfigViewModel = _ThemeConfigViewModel with _$ThemeConfigViewModel;

abstract class _ThemeConfigViewModel with Store {  
  
  @observable
  Color pickerColor = Color(0xFF666CDE);
  @action 
  void setPickerColor(Color _) => pickerColor = _;

  @observable
  Color currentColor = Color(0xFF666CDE);
  @action 
  void setCurrentColor(Color _) => pickerColor = _;


  bool isPersonalized(BuildContext context) {
    bool value = true;
    for(Map map in themePrimaryColors){
      if(map['color'] == Theme.of(context).primaryColor){
        value = false;
      }
    }
    return value;
  }

  colorPicker(BuildContext context){
    showDialog(
      context: context,
      builder: (a) =>      
      AlertDialog(
        title: const Text('Escolha uma cor!'),

        backgroundColor: Theme.of(context).backgroundColor,
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: pickerColor,
            onColorChanged: setPickerColor,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20),
            child: Button(
              text: 'Confirmar', 
              onPress: () async {
                AppWidget.setTheme(context, pickerColor);
                setCurrentColor(pickerColor);
                Navigator.of(context).pop();
              },
              size: Size(150,50)),
          )
        ],
      ),
    );
  }

}