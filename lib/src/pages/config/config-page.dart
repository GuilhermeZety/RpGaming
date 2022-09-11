import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rpgaming/src/components/Button.dart';
import '../../Util/constants.dart';
import '../../app_widget.dart';
import '../../components/bars/BottomMenuBar.dart';

import '../../components/bars/TopMenuBar.dart';
import '../../components/bars/UserMenuBar.dart';
import '../../components/bars/navbar/Navbar.dart';
import '../../components/check-box.dart';


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
    bool value = true;

    for(var color in colors){
      if(color == Theme.of(context).primaryColor){
        value = false;
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getWhatSize(context) == Orientation.portrait ? TopMenuBar(height: 100, name: 'Configurações') : null,
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        child: getContentBasedInOrientation()
      ),
      bottomNavigationBar: getWhatSize(context) == Orientation.portrait ? BottomMenuBar(gearIsActive: true, colorBack: Theme.of(context).backgroundColor) : null,
    );
  }

  // create some values
  Color pickerColor = Color(0xFF666CDE);
  Color currentColor = Color(0xFF666CDE);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }


  colorPicker(){
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (a) =>
      
      AlertDialog(
        title: const Text('Escolha uma cor!'),

        backgroundColor: Theme.of(context).backgroundColor,
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20),
            child: Button(
              text: 'Confirmar', 
              onPress: () async {
                AppWidget.setTheme(context, pickerColor);
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
              size: Size(150,50)),
          )
        ],
      ),
    );
  }

  
  getContentBasedInOrientation(){    
    if(getWhatSize(context) == Orientation.landscape){ 
      return Row(
        children: [
          Navbar(gearIsActive: true),
          Container(
            width: MediaQuery.of(context).size.width - 300,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 0),
            child: Column(
              children: [
                UserMenuBar(),
                Center(
                  child: Container(
                    width: 650,
                    height: MediaQuery.of(context).size.height - 90,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 650,
                          height: 100,
                          margin: EdgeInsets.only(bottom: 40,),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                          ),
                          child: TopMenuBar(
                            height: 100, 
                            name: 'Configurações',
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          ).getWidget(context)
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 270,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DefaultTabController(
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
                                    children: [
                                      //Temas Tab
                                      Container(
                                        child: ListView(
                                          children: [
                                            SizedBox(height: 10),
                                            SeletableCheckboxCard(
                                              color: colors[0] , 
                                              name: 'Lilás',
                                              onClick: () => AppWidget.setTheme(context, colors[0]),
                                            ),
                                            SeletableCheckboxCard(
                                              color: colors[1] , 
                                              name: 'Roxo',
                                              onClick: () => AppWidget.setTheme(context, colors[1]),
                                            ),
                                            SeletableCheckboxCard(
                                              color: colors[2] , 
                                              name: 'Ciano',
                                              onClick: () => AppWidget.setTheme(context, colors[2]),
                                            ),
                                            SeletableCheckboxCard(
                                              color: colors[3], 
                                              name: 'Amarelo',
                                              onClick: () => AppWidget.setTheme(context, colors[3]),
                                            ),
                                           SeletableCheckboxCard(
                                              imagePath: 'assets/images/gradient.jpg',
                                              name: 'Personalizado', 
                                              onClick: () => colorPicker(),
                                              isPersonalized: isPersonalized()
                                            ),
                                          ],
                                        )
                                      ),                                      
                                      Center(
                                        child: Text('Em desenvolvimento!'),
                                      )
                                    ]
                                  ),
                                )
                              ]
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                )
              ]
            )
          )
        ],
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height - 270,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultTabController(
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
                        SeletableCheckboxCard(
                          color: colors[0], 
                          name: 'Lilás',
                          onClick: () => AppWidget.setTheme(context, colors[0]),
                        ),
                        SeletableCheckboxCard(
                          color: colors[1] , 
                          name: 'Roxo',
                          onClick: () => AppWidget.setTheme(context, colors[1]),
                        ),
                        SeletableCheckboxCard(
                          color: colors[2] , 
                          name: 'Ciano',
                          onClick: () => AppWidget.setTheme(context, colors[2]),
                        ),
                        SeletableCheckboxCard(
                          color: colors[3], 
                          name: 'Amarelo',
                          onClick: () => AppWidget.setTheme(context, colors[3]),
                        ),
                        SeletableCheckboxCard(
                          imagePath: 'assets/images/gradient.jpg',
                          name: 'Personalizado', 
                          onClick: () => colorPicker(),
                          isPersonalized: isPersonalized()
                        ),
                      ],
                    )
                  ),
                  Center(
                    child: Text('Em desenvolvimento!'),
                  )
                  // Container(
                  //   child: ListView(
                  //     children: [
                  //       SizedBox(height: 10),
                  //       SeletableCheckboxCard(
                  //         color: colors[0], 
                  //         name: 'Portugues',
                  //         onClick: () => AppWidget.setTheme(context, colors[0]),
                  //       ),
                  //       SeletableCheckboxCard(
                  //         color: colors[1] , 
                  //         name: 'English',
                  //         onClick: () => AppWidget.setTheme(context, colors[1]),
                  //       ),
                  //     ],
                  //   )
                  // ),
                ]
              ),
            )
          ]
        )
      )
    );
  }

}

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
                  color: getWhatSize(context) == Orientation.portrait ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).backgroundColor,
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



