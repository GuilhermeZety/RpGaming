import 'package:flutter/material.dart';
import '../../app_widget.dart';
import '../../components/bars/BottomMenuBar.dart';

import '../../components/bars/TopMenuBar.dart';
import '../../components/check-box.dart';
import '../../styles/CustomTheme.dart';


class ConfigPage extends StatefulWidget{
  ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
  
}

List<Color> colors = [
  Color(0xFF666CDE),
  Color(0xFF7A1AC6),
  Color(0xFF3FD9C6),
  Color(0xFFC3C33C)
];

class _ConfigPageState extends State<ConfigPage> {


  bool isPersonalized() {
    // bool value = true;

    // for(var color in colors){
    //   if(color == Theme.of(context).primaryColor){
    //     value = false;
    //   }
    // }
    // print(Theme.of(context).primaryColor.toString());
    // return value;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = CustomTheme();

    return Scaffold(
      appBar: TopMenuBar(height: 100, name: 'Configurações'),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(                
                children: <Widget>[
                  Container(
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,                      
                      tabs: [
                        Tab(child: Text('Temas', style: TextStyle(fontSize: 16))),
                        Tab(child: Text('Linguagens', style: TextStyle(fontSize: 16))),
                      ],
                    ),
                  ),
                  Container(
                    height: 400, //height of TabBarView
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                    ),
                    child: TabBarView(
                      children: <Widget>[
                        //Temas Tab
                        Container(
                          child: ListView(
                            children: [
                              SizedBox(height: 10),
                              ThemeChoose(
                                color: colors[0] , 
                                name: 'Lilás',
                                onClick: () => AppWidget.setTheme(context, colors[0]),
                              ),
                              ThemeChoose(
                                color: colors[1] , 
                                name: 'Roxo',
                                onClick: () => AppWidget.setTheme(context, colors[1]),
                              ),
                              ThemeChoose(
                                color: colors[2] , 
                                name: 'Ciano',
                                onClick: () => AppWidget.setTheme(context, colors[2]),
                              ),
                              ThemeChoose(
                                color: colors[3], 
                                name: 'Amarelo',
                                onClick: () => AppWidget.setTheme(context, colors[3]),
                              ),
                              ThemeChoose(
                                color: const Color(0xFFFFFFFF), 
                                name: 'Personalizado', 
                                isPersonalized: isPersonalized()
                              ),
                            ],
                          )
                        ),
                        Container(
                          child: Center(
                            child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ]
                    ),
                  )
                ]
              )
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomMenuBar(gearIsActive: true, colorBack: Theme.of(context).backgroundColor),
    );
  }
}

class ThemeChoose extends StatelessWidget {
  const ThemeChoose({Key? key, required this.color, required this.name, this.isPersonalized, this.onClick}) : super(key: key);
  
  final Color color;
  final String name;
  final bool? isPersonalized;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
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
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(5)
                        ),
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
    );
  }
}



