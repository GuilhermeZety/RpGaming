// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change-password-viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordViewModel on _ForgotPasswordViewModel, Store {
  late final _$passwordControllerAtom = Atom(
      name: '_ForgotPasswordViewModel.passwordController', context: context);

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
      name: '_ForgotPasswordViewModel.repeatPasswordController',
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

  late final _$_ForgotPasswordViewModelActionController =
      ActionController(name: '_ForgotPasswordViewModel', context: context);

  @override
  void setPasswordControllerText(String _) {
    final _$actionInfo = _$_ForgotPasswordViewModelActionController.startAction(
        name: '_ForgotPasswordViewModel.setPasswordControllerText');
    try {
      return super.setPasswordControllerText(_);
    } finally {
      _$_ForgotPasswordViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRepeatPasswordControllerText(String _) {
    final _$actionInfo = _$_ForgotPasswordViewModelActionController.startAction(
        name: '_ForgotPasswordViewModel.setRepeatPasswordControllerText');
    try {
      return super.setRepeatPasswordControllerText(_);
    } finally {
      _$_ForgotPasswordViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
passwordController: ${passwordController},
repeatPasswordController: ${repeatPasswordController}
    ''';
  }
}
