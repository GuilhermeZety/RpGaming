import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'theme-config-viewmodel.dart';
import '../../../components/cards/selectable-checkbox-card.dart';
import '../../../components/model/landscape-page-model.dart';
import '../configs-page.dart';
import '../../../Util/constants.dart';
import '../../../api/auth_required_state.dart';
import '../../../app_widget.dart';
import '../../../components/bars/bottom-menu-bar.dart';

import '../../../components/bars/top-menu-bar.dart';
import '../../../components/bars/navbar/navbar.dart';


class ThemeConfigPage extends StatefulWidget{
  static const String route = '/theme-config';
  const ThemeConfigPage({Key? key}) : super(key: key);

  @override
  State<ThemeConfigPage> createState() => _ThemeConfigPageState();
}

class _ThemeConfigPageState extends AuthRequiredState<ThemeConfigPage> {
  var controller = ThemeConfigViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isPortrait(context) ? TopMenuBar(height: 100, name: 'Temas') : null,
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Observer(
          builder: (_) =>         
            getContentBasedInOrientation()
        )
      ),
      bottomNavigationBar: isPortrait(context) ? BottomMenuBar(gearIsActive: true, colorBack: Theme.of(context).backgroundColor) : null,
    );
  }  
  
  getContentBasedInOrientation(){    
    if(isLandscape(context)){ 
      return LandscapePageModel(
        navbar: Navbar(gearIsActive: true),
        topMenuName: "Temas",
        topMenuBackPage: ConfigsPage(),
        topMenuColor: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          height: MediaQuery.of(context).size.height - 270,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(                
            children: [
              Container(
                height: 232,
                child: ListView.builder(
                  itemCount: themePrimaryColors.length,
                  
                  itemBuilder: (_, i) => 
                  SeletableCheckboxCard(
                    name: themePrimaryColors[i]['name'],
                    color: themePrimaryColors[i]['color'],
                    onClick: () => AppWidget.setTheme(context, themePrimaryColors[i]['color']),
                  )                                
                ),
              ),
              SeletableCheckboxCard(
                imagePath: 'assets/images/gradient.jpg',
                name: 'Personalizado', 
                onClick: () => controller.colorPicker(context),
                isPersonalized: controller.isPersonalized(context)
              ),
            ]
          )
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height - 160,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(                
        children: [
          Container(
            height: 232,
            child: ListView.builder(
              itemCount: themePrimaryColors.length,
              itemBuilder: (_, i) => 
              SeletableCheckboxCard(
                name: themePrimaryColors[i]['name'],
                color: themePrimaryColors[i]['color'],
                onClick: () => AppWidget.setTheme(context, themePrimaryColors[i]['color']),
              )                                
            ),
          ),
          SeletableCheckboxCard(
            imagePath: 'assets/images/gradient.jpg',
            name: 'Personalizado', 
            onClick: () => controller.colorPicker(context),
            isPersonalized: controller.isPersonalized(context)
          ),
        ]
      )
    );
  }
}