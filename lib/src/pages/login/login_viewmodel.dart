
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  var emailController = ValueNotifier<TextEditingController>(TextEditingController());
  var passwordController = ValueNotifier<TextEditingController>(TextEditingController());
}
