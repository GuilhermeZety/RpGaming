import 'package:flutter/cupertino.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/enums/gender_person.dart';

import 'package:rpgaming/src/pages/create-account/continue_create_account_page.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  var emailController = ValueNotifier<TextEditingController>(TextEditingController());
  var passwordController = ValueNotifier<TextEditingController>(TextEditingController());
  var repeatPasswordController = ValueNotifier<TextEditingController>(TextEditingController());
  var dateController = ValueNotifier<TextEditingController>(TextEditingController());
  var genderPerson = ValueNotifier<GenderPerson>(GenderPerson.male);

  validate(context, controller) async {
     if (formKey.currentState!.validate()) {
        await to(context, ContinueCreateAccountPage(controller: controller));
      }
  }  
  setGender(value){
    genderPerson.value = value;
  }
}