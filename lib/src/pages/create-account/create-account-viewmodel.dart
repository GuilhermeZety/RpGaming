import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/constants.dart';
import '../../Util/navigate.dart';
import '../../Util/toasts.dart';
import '../../enums/gender_person.dart';
import '../../models/response-model.dart';
import '../home/home_page.dart';
import '../login/login-page.dart';
import '../login/login-viewmodel.dart';
import 'continue-create-account-page.dart';

part 'create-account-viewmodel.g.dart';

class CreateAccountViewModel = _CreateAccountViewModel with _$CreateAccountViewModel;

abstract class _CreateAccountViewModel with Store {
  final loginController = LoginViewModel();
  
  final formKey = GlobalKey<FormState>();

  @observable
  TextEditingController nameController = TextEditingController();
  @action 
  void setNameControllerText(String _) => nameController.text = _;
  
  @observable
  TextEditingController lastNameController = TextEditingController();
  @action 
  void setLastNameControllerText(String _) => lastNameController.text = _;
  
  @observable
  TextEditingController emailController = TextEditingController();
  @action 
  void setEmailControllerText(String _) => emailController.text = _;

  @observable
  TextEditingController passwordController = TextEditingController();
  @action 
  void setPasswordControllerText(String _) => passwordController.text = _;

  @observable
  TextEditingController repeatPasswordController = TextEditingController();
  @action 
  void setRepeatPasswordControllerText(String _) => repeatPasswordController.text = _;

  @observable
  TextEditingController dateController = TextEditingController();
  @action 
  void setDateControllerText(String _) => dateController.text = _;

  @observable
  TextEditingController genderController = TextEditingController();
  @action 
  void setGenderControllerText(String _) => genderController.text = _;

  @observable
  GenderPerson genderPerson = GenderPerson.male;
  @action 
  void setGenderPerson(GenderPerson _) => genderPerson = _;


  handleSignIn(context, Provider? provider) async {
    ResponseModel? response = await loginController.signIn(provider);

    if(response != null){
      if(response.success){
        showSuccessToast(fToast: FToast().init(context), message: response.message);
        to(context, HomePage());
      }
      else if(response.isWarning){
        showWarningToast(fToast: FToast().init(context), message: response.message);
      }
      else {
        showErrorToast(fToast: FToast().init(context), error: response.message);
      }
    }
  }

  Future<bool> _signIn(context, controller) async {
    try{
      GotrueSessionResponse res = await supabase.auth.signIn(
        email: emailController.value.text,
        password: passwordController.value.text
      );
      if(res.error != null){
        return false;
      }
      else{
        if(res.data != null){
          User? user = res.data?.user;
          supabase.auth.currentUser = user;
          
          to(context, HomePage());
          
          return true;
        }
      }
    }
    catch(err){
      print(err);
    }

    return false;
  }

  validate(context, controller) async {
    if (formKey.currentState!.validate()) {
      if(await _signIn(context, controller) == false){
        await to(context, ContinueCreateAccountPage(controller: controller));
      }
    }
  }  

  getGender(){
    if(genderPerson == GenderPerson.male){
      return 'Male';
    }
    else if(genderPerson == GenderPerson.female){
      return 'Female';
    }
    else if(genderPerson == GenderPerson.other){
      return 'Other';
    }
  }

  getGenderValue(){
    if(genderPerson == GenderPerson.male){
      return 'Masculino';
    }
    else if(genderPerson == GenderPerson.female){
      return 'Feminino';
    }
    else if(genderPerson == GenderPerson.other){
      return genderController.text;
    }
  }
  
  correctFields(){
    setNameControllerText(nameController.text.trim());
    setLastNameControllerText(lastNameController.text.trim());
    setEmailControllerText(emailController.text.trim());
    setPasswordControllerText(passwordController.text.trim());
    setDateControllerText(dateController.text.trim());
    setGenderControllerText(genderController.text.trim());
  }

  Future<void> signUp(BuildContext context) async {  
    if (formKey.currentState!.validate()) {
      correctFields();

      GotrueSessionResponse response = await supabase.auth.signUp(
        emailController.text,
        passwordController.text
      );
      
      if(response.error != null){
        showWarningToast(fToast: FToast().init(context), message: response.error!.message);
      }
      if(response.user != null){
        final informations = {
          'id': response.user!.id,
          'name': nameController.value.text,
          'last_name': lastNameController.value.text,
          'nickname': nameController.value.text.split(" ").first,
          'birthday': toTimestampString(DateFormat('dd/MM/yyyy').parse(dateController.text).toIso8601String()),
          'gender': getGender(),
          'gender_value': getGenderValue()
        };

        final resp = await supabase.from('user').upsert(informations).execute();

        if(resp.error != null){
          showWarningToast(fToast: FToast().init(context), message: response.error!.message);
        }
        if(resp.data != null){
          showWarningToast(fToast: FToast().init(context), message: 'cadastrado com sucesso, por favor verifique seu email para poder acessar');
          to(context, LoginPage());
        }
      }
    }
  }

}