// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change-password-viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChangePasswordViewModel on _ChangePasswordViewModel, Store {
  late final _$passwordControllerAtom = Atom(
      name: '_ChangePasswordViewModel.passwordController', context: context);

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

  late final _$_ChangePasswordViewModelActionController =
      ActionController(name: '_ChangePasswordViewModel', context: context);

  @override
  void setPasswordControllerText(String _) {
    final _$actionInfo = _$_ChangePasswordViewModelActionController.startAction(
        name: '_ChangePasswordViewModel.setPasswordControllerText');
    try {
      return super.setPasswordControllerText(_);
    } finally {
      _$_ChangePasswordViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
passwordController: ${passwordController}
    ''';
  }
}
