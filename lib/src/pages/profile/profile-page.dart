import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rpgaming/src/Cache.dart';
import 'package:rpgaming/src/Util/NetworkInfo.dart';
import 'package:rpgaming/src/components/Button.dart';
import 'package:rpgaming/src/components/skeleted/TextSkeleted.dart';
import 'package:skeletons/skeletons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/constants.dart';
import '../../Util/format.dart';
import '../../Util/toasts.dart';
import '../../Util/utils.dart';
import '../../api/auth_required_state.dart';
import '../../api/profile/updateUser.dart';
import '../../components/DateTimePicker.dart';
import '../../components/Input.dart';
import '../../components/bars/BottomMenuBar.dart';
import '../../components/bars/TopMenuBar.dart';
import '../../components/bars/UserMenuBar.dart';
import '../../components/bars/navbar/Navbar.dart';
import '../../components/skeleted/InputSkeleted.dart';
import '../../enums/gender_person.dart';
import '../../models/UserInfo.dart';

class ProfilePage extends StatefulWidget {
  static const String route = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends AuthRequiredState<ProfilePage> {
  bool _isLoading = true;
  
  Session? currentSession;
  UserInfo? userInfo;

  FToast fToast = FToast();
  
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GenderPerson genderPerson = GenderPerson.male;
  TextEditingController genderController = TextEditingController();


  @override
  initState() {
    super.initState();
    fToast.init(context);
    Timer.run(() => onLoad());
  }  

  onLoad() async {
    currentSession = supabase.auth.currentSession;
    userInfo = await Cache().getUserInfo();

    if(userInfo != null){
      setState(() {
        nameController.text = userInfo!.name!;
        lastNameController.text = userInfo!.last_name!;
        dateController.text = userInfo!.birthday != null ? formatDateToddMMyyyy(userInfo!.birthday!) : formatDateToddMMyyyy(DateTime.now());
        genderPerson = userInfo!.gender != null ? userInfo!.gender! : GenderPerson.male;
        genderController.text = userInfo!.gender_value != null ? userInfo!.gender_value! : '';        
      });
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isPortrait(context) ? TopMenuBar(height: 100, name: 'Perfil') : null,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: getContentBasedInOrientation()
      ),
      bottomNavigationBar: isPortrait(context) ? BottomMenuBar(userIsActive: true, colorBack: Theme.of(context).backgroundColor) : null,
    );
  }

  saveInformationsUser() async {
    if(formKey.currentState!.validate()){      
      if(userInfo != null){
        setState(() {
          userInfo!.name = nameController.text;
          userInfo!.nickname = (nameController.text + ' ' + lastNameController.text).replaceAll('  ', ' ');
          userInfo!.last_name = lastNameController.text;
          userInfo!.gender = genderPerson;
          userInfo!.gender_value = getGenderValue(genderPerson, genderController);
          userInfo!.birthday = DateFormat('dd/MM/yyyy').parse(dateController.text);
        });

        await updateAtUser(userInfo!);

        if(await hasInternetConnection()){
          await updateUserInfo(userInfo!);
        }

        showSuccessToast(message: 'informações atualizadas com sucesso!', fToast: fToast);
      }
    }
  }

  pickImage() async {
    try {      
      if(!await hasInternetConnection()){
        showWarningToast(message: 'Tenha acesso à internet para fazer upload de imagem', fToast: fToast);
        return;
      }

      //chamar loader
      setState(() {
        _isLoading = true;
      });
      
      final imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
      );

      if(imageFile == null){
        showWarningToast(message: 'Nenhuma imagem selecionada', fToast: fToast);        
        setState(() {
          _isLoading = false;
        });
        return;
      }
      
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final filePath = '${DateTime.now().toIso8601String()}.$fileExt';

      final response = await supabase.storage.from('avatars').uploadBinary(filePath, bytes);

      if (response.error != null) {
        showWarningToast(message: response.error!.message, fToast: fToast);
        
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final imageUrlResponse = supabase.storage.from('avatars').getPublicUrl(filePath);
      
      String? newUrl = imageUrlResponse.data;

      if(newUrl != null){
        setState(() {
          userInfo = userInfo?.copyWith(
            avatar_url: newUrl
          );
        });
        
        var hasUpdate = await updateAtUser(userInfo!);

        if(hasUpdate){
          showSuccessToast(message: 'Foto de perfil alterada', fToast: fToast);
        }
      }
    }
    catch(err){
      print(err);
    }
    
    //fechar loader
    setState(() {
      _isLoading = false;
    });
  }

  getContentBasedInOrientation(){    
    if(isLandscape(context)){ 
      return Row(
        children: [
          Navbar(userIsActive: true),
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
                    child: 
                    Column(
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
                            name: 'Perfil',
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          ).getWidget(context)
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 280,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () async  => await pickImage(),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 200
                                        ),
                                        child: Skeleton(
                                          isLoading: _isLoading,
                                          skeleton: ClipOval(
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.black,
                                            ) ,
                                          ),
                                          child: userInfo != null ? 
                                            ClipOval(child: userInfo!.avatar_url != null ? Image.network(userInfo!.avatar_url! , width: 100, height: 100,) 
                                              : Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.black,
                                              ),
                                          ) : SizedBox(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: TextSkeleted(
                                            isLoading: _isLoading,
                                            child: Text(userInfo != null ? userInfo!.nickname! : ''),
                                            sizeSkeleton: Size(400, 20),
                                          ),
                                        ),  
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: TextSkeleted(
                                            isLoading: _isLoading,
                                            child: Text(userInfo != null ? currentSession!.user!.email! : ''),
                                            sizeSkeleton: Size(400, 20),
                                          ),
                                        ),                                        
                                        Row(
                                          children: [
                                            TextSkeleted(
                                              isLoading: _isLoading,
                                              child: Text(
                                                userInfo != null ? userInfo!.account_id : ''
                                              ),
                                              sizeSkeleton: Size(400, 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              DefaultTabController(
                                length: 1,
                                initialIndex: 0,
                                child: Column(                
                                  children: <Widget>[
                                    Container(
                                      child: TabBar(
                                        indicatorColor: Theme.of(context).primaryColor,                      
                                        tabs: [
                                          Tab(child: Text('Informações do usuário', style: TextStyle(fontSize: 16))),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 20),
                                      height: MediaQuery.of(context).size.height - 230 ,
                                      decoration: BoxDecoration(
                                        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                                      ),
                                      child: TabBarView(
                                        children: [
                                          Form(
                                            key: formKey,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            child: Column(
                                              children: [
                                                InputSkeleted(
                                                  isLoading: _isLoading,
                                                  child: Input(
                                                    controller: nameController,
                                                    type: TextInputType.name,                            
                                                    label: const Text('Name'),
                                                    hintText: 'insira seu primeiro nome...',
                                                    obscure: false,
                                                  ),
                                                ),
                                                InputSkeleted(
                                                  isLoading: _isLoading,
                                                  child: Input(
                                                    controller: lastNameController,
                                                    type: TextInputType.name,                            
                                                    label: const Text('Sobrenome'),
                                                    hintText: 'insira seu sobrenome...',
                                                    obscure: false,
                                                  ),
                                                ),                                               
                                                InputSkeleted(
                                                  isLoading: _isLoading,
                                                  child: InputDateTime(
                                                    dateController: dateController, 
                                                    label: 'Data de nascimento', 
                                                    onchange: () => formKey.currentState?.validate()
                                                  ),
                                                ),

                                                InputSkeleted(
                                                  isLoading: _isLoading,
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 75,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                height: 70,
                                                                padding: EdgeInsets.only(bottom: 14),
                                                                child: DropdownButton<GenderPerson>(
                                                                  itemHeight: 50,
                                                                  dropdownColor: const Color(0xFF2F2F3C),
                                                                  value: genderPerson,
                                                                  underline: Container(
                                                                    decoration: const BoxDecoration(
                                                                      border: Border(
                                                                        bottom: BorderSide(
                                                                          color: Color(0xFF737379),
                                                                          width: 1.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                                                                  items: const [
                                                                    DropdownMenuItem(value: GenderPerson.male, child: Text('Masculino')),
                                                                    DropdownMenuItem(value: GenderPerson.female, child: Text('Feminino')),
                                                                    DropdownMenuItem(value: GenderPerson.other, child: Text('Outro')),
                                                                  ],
                                                                  onChanged: (value) => setState(() {
                                                                    genderPerson = value!;                                              
                                                                  })
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),                                  
                                                        genderPerson == GenderPerson.other ?
                                                          Flexible(
                                                            child: Container(
                                                              margin: const EdgeInsets.only(left: 20), 
                                                              child: Input(
                                                                controller: genderController, 
                                                                type: TextInputType.text, 
                                                                label: Text('gênero'), 
                                                                hintText: 'Insira seu gênero...'
                                                              )
                                                            )
                                                          )
                                                        : const SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Button(text: 'Salvar', onPress: () async => await saveInformationsUser(), size: Size(150, 50)),
                                                  ],
                                                )
                                              ] 
                                            ),
                                          
                                          )
                                        ],
                                      )
                                    )
                                  ]
                                )
                              )
                            ],
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
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async  => await pickImage(),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 200
                    ),
                    child: Skeleton(
                      isLoading: _isLoading,
                      skeleton: ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ) ,
                      ),
                      child: userInfo != null ? 
                        ClipOval(child: userInfo!.avatar_url != null ? Image.network(userInfo!.avatar_url! , width: 100, height: 100,) 
                          : Container(
                            width: 100,
                            height: 100,
                            color: Colors.black,
                          ),
                      ) : SizedBox(),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: TextSkeleted(
                        isLoading: _isLoading,
                        child: Text(userInfo != null ? userInfo!.nickname! : ''),
                        sizeSkeleton: Size(MediaQuery.of(context).size.width - 170, 20),
                      ),
                    ),                  
                    Row(
                      children: [
                        TextSkeleted(
                          isLoading: _isLoading,
                          child: Text(
                            userInfo != null ? userInfo!.account_id : ''
                          ),
                          sizeSkeleton: Size(MediaQuery.of(context).size.width - 170, 20),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          DefaultTabController(
            length: 1,
            initialIndex: 0,
            child: Column(                
              children: <Widget>[
                Container(
                  child: TabBar(
                    indicatorColor: Theme.of(context).primaryColor,                      
                    tabs: [
                      Tab(child: Text('Informações do usuário', style: TextStyle(fontSize: 16))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height - 290,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                  ),
                  child: TabBarView(
                    children: [
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            InputSkeleted(
                              isLoading: _isLoading,
                              child: Input(
                                controller: nameController,
                                type: TextInputType.name,                            
                                label: const Text('Name'),
                                hintText: 'insira seu primeiro nome...',
                                obscure: false,
                              ),
                            ),
                            InputSkeleted(
                              isLoading: _isLoading,
                              child: Input(
                                controller: lastNameController,
                                type: TextInputType.name,                            
                                label: const Text('Sobrenome'),
                                hintText: 'insira seu sobrenome...',
                                obscure: false,
                              ),
                            ),                          
                            InputSkeleted(
                              isLoading: _isLoading,
                              child: InputDateTime(
                                dateController: dateController, 
                                label: 'Data de nascimento', 
                                onchange: () => formKey.currentState?.validate()
                              ),
                            ),

                            InputSkeleted(
                              isLoading: _isLoading,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 75,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 70,
                                            padding: EdgeInsets.only(bottom: 14),
                                            child: DropdownButton<GenderPerson>(
                                              itemHeight: 50,
                                              dropdownColor: const Color(0xFF2F2F3C),
                                              value: genderPerson,
                                              underline: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color(0xFF737379),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                                              items: const [
                                                DropdownMenuItem(value: GenderPerson.male, child: Text('Masculino')),
                                                DropdownMenuItem(value: GenderPerson.female, child: Text('Feminino')),
                                                DropdownMenuItem(value: GenderPerson.other, child: Text('Outro')),
                                              ],
                                              onChanged: (value) => setState(() {
                                                genderPerson = value!;                                              
                                              })
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),                                  
                                    genderPerson == GenderPerson.other ?
                                      Flexible(
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 20), 
                                          child: Input(
                                            controller: genderController, 
                                            type: TextInputType.text, 
                                            label: Text('gênero'), 
                                            hintText: 'Insira seu gênero...'
                                          )
                                        )
                                      )
                                    : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Button(text: 'Salvar', onPress: () async => await saveInformationsUser(), size: Size(150, 50)),
                              ],
                            )
                          ] 
                        ),
                      
                      )
                    ],
                  )
                )
              ]
            )
          )
        ],
      )
    );
  }
}