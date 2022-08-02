import 'package:flutter/cupertino.dart';
import 'package:rpgaming/src/Util/constants.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/enums/gender_person.dart';

import 'package:rpgaming/src/pages/create-account/continue_create_account_page.dart';
import 'package:rpgaming/src/pages/home/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  var nameController = ValueNotifier<TextEditingController>(TextEditingController());
  var lastNameController = ValueNotifier<TextEditingController>(TextEditingController());
  var emailController = ValueNotifier<TextEditingController>(TextEditingController());
  var passwordController = ValueNotifier<TextEditingController>(TextEditingController());
  var repeatPasswordController = ValueNotifier<TextEditingController>(TextEditingController());
  var dateController = ValueNotifier<TextEditingController>(TextEditingController());
  var genderController = ValueNotifier<TextEditingController>(TextEditingController());
  var genderPerson = ValueNotifier<GenderPerson>(GenderPerson.male);

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
  setGender(value){
    genderPerson.value = value;
  }
}