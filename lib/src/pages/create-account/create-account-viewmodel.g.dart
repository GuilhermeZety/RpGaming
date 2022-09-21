// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-account-viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateAccountViewModel on _CreateAccountViewModel, Store {
  late final _$nameControllerAtom =
      Atom(name: '_CreateAccountViewModel.nameController', context: context);

  @override
  TextEditingController get nameController {
    _$nameControllerAtom.reportRead();
    return super.nameController;
  }

  @override
  set nameController(TextEditingController value) {
    _$nameControllerAtom.reportWrite(value, super.nameController, () {
      super.nameController = value;
    });
  }

  late final _$lastNameControllerAtom = Atom(
      name: '_CreateAccountViewModel.lastNameController', context: context);

  @override
  TextEditingController get lastNameController {
    _$lastNameControllerAtom.reportRead();
    return super.lastNameController;
  }

  @override
  set lastNameController(TextEditingController value) {
    _$lastNameControllerAtom.reportWrite(value, super.lastNameController, () {
      super.lastNameController = value;
    });
  }

  late final _$emailControllerAtom =
      Atom(name: '_CreateAccountViewModel.emailController', context: context);

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  late final _$passwordControllerAtom = Atom(
      name: '_CreateAccountViewModel.passwordController', context: context);

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  late final _$repeatPasswordControllerAtom = Atom(
      name: '_CreateAccountViewModel.repeatPasswordController',
      context: context);

  @override
  TextEditingController get repeatPasswordController {
    _$repeatPasswordControllerAtom.reportRead();
    return super.repeatPasswordController;
  }

  @override
  set repeatPasswordController(TextEditingController value) {
    _$repeatPasswordControllerAtom
        .reportWrite(value, super.repeatPasswordController, () {
      super.repeatPasswordController = value;
    });
  }

  late final _$dateControllerAtom =
      Atom(name: '_CreateAccountViewModel.dateController', context: context);

  @override
  TextEditingController get dateController {
    _$dateControllerAtom.reportRead();
    return super.dateController;
  }

  @override
  set dateController(TextEditingController value) {
    _$dateControllerAtom.reportWrite(value, super.dateController, () {
      super.dateController = value;
    });
  }

  late final _$genderControllerAtom =
      Atom(name: '_CreateAccountViewModel.genderController', context: context);

  @override
  TextEditingController get genderController {
    _$genderControllerAtom.reportRead();
    return super.genderController;
  }

  @override
  set genderController(TextEditingController value) {
    _$genderControllerAtom.reportWrite(value, super.genderController, () {
      super.genderController = value;
    });
  }

  late final _$genderPersonAtom =
      Atom(name: '_CreateAccountViewModel.genderPerson', context: context);

  @override
  GenderPerson get genderPerson {
    _$genderPersonAtom.reportRead();
    return super.genderPerson;
  }

  @override
  set genderPerson(GenderPerson value) {
    _$genderPersonAtom.reportWrite(value, super.genderPerson, () {
      super.genderPerson = value;
    });
  }

  late final _$_CreateAccountViewModelActionController =
      ActionController(name: '_CreateAccountViewModel', context: context);

  @override
  void setNameControllerText(String _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setNameControllerText');
    try {
      return super.setNameControllerText(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastNameControllerText(String _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setLastNameControllerText');
    try {
      return super.setLastNameControllerText(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmailControllerText(String _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setEmailControllerText');
    try {
      return super.setEmailControllerText(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordControllerText(String _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setPasswordControllerText');
    try {
      return super.setPasswordControllerText(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRepeatPasswordControllerText(String _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setRepeatPasswordControllerText');
    try {
      return super.setRepeatPasswordControllerText(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateControllerText(String _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setDateControllerText');
    try {
      return super.setDateControllerText(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGenderControllerText(String _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setGenderControllerText');
    try {
      return super.setGenderControllerText(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGenderPerson(GenderPerson _) {
    final _$actionInfo = _$_CreateAccountViewModelActionController.startAction(
        name: '_CreateAccountViewModel.setGenderPerson');
    try {
      return super.setGenderPerson(_);
    } finally {
      _$_CreateAccountViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nameController: ${nameController},
lastNameController: ${lastNameController},
emailController: ${emailController},
passwordController: ${passwordController},
repeatPasswordController: ${repeatPasswordController},
dateController: ${dateController},
genderController: ${genderController},
genderPerson: ${genderPerson}
    ''';
  }
}
