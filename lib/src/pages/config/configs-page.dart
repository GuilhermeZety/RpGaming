import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../home/home_page.dart';
import '../../components/model/landscape-page-model.dart';
import 'theme/theme-config-page.dart';
import '../../Util/constants.dart';
import '../../Util/navigate.dart';
import '../../api/auth_required_state.dart';
import '../../components/bars/bottom-menu-bar.dart';

import '../../components/bars/top-menu-bar.dart';
import '../../components/bars/navbar/navbar.dart';
import '../../components/selectable-tile.dart';


class ConfigsPage extends StatefulWidget{
  static const String route = '/config';
  const ConfigsPage({Key? key}) : super(key: key);

  @override
  State<ConfigsPage> createState() => _ConfigsPageState();
}

class _ConfigsPageState extends AuthRequiredState<ConfigsPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isPortrait(context) ? TopMenuBar(height: 100, name: 'Configurações') : null,
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
        topMenuName: "Configurações",
        topMenuBackPage: HomePage(),
        topMenuColor: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          height: MediaQuery.of(context).size.height - 270,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SelectableTile(
                title: 'Temas',
                backIcon: FontAwesomeIcons.palette,
                onTap: () => to(context, ThemeConfigPage()),
              ),
              SelectableTile(
                title: 'Linguagens',
                backIcon: Icons.language,
                onTap: () {},
              ),
            ],
          )
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height - 160,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          SelectableTile(
            title: 'Temas',
            backIcon: FontAwesomeIcons.palette,
            onTap: () => to(context, ThemeConfigPage()),
          ),
          SelectableTile(
            title: 'Linguagens',
            backIcon: Icons.language,
            onTap: () {},
          ),
        ],
      )
    );
  }
}