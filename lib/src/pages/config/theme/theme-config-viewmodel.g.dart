// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme-config-viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeConfigViewModel on _ThemeConfigViewModel, Store {
  late final _$pickerColorAtom =
      Atom(name: '_ThemeConfigViewModel.pickerColor', context: context);

  @override
  Color get pickerColor {
    _$pickerColorAtom.reportRead();
    return super.pickerColor;
  }

  @override
  set pickerColor(Color value) {
    _$pickerColorAtom.reportWrite(value, super.pickerColor, () {
      super.pickerColor = value;
    });
  }

  late final _$currentColorAtom =
      Atom(name: '_ThemeConfigViewModel.currentColor', context: context);

  @override
  Color get currentColor {
    _$currentColorAtom.reportRead();
    return super.currentColor;
  }

  @override
  set currentColor(Color value) {
    _$currentColorAtom.reportWrite(value, super.currentColor, () {
      super.currentColor = value;
    });
  }

  late final _$_ThemeConfigViewModelActionController =
      ActionController(name: '_ThemeConfigViewModel', context: context);

  @override
  void setPickerColor(Color _) {
    final _$actionInfo = _$_ThemeConfigViewModelActionController.startAction(
        name: '_ThemeConfigViewModel.setPickerColor');
    try {
      return super.setPickerColor(_);
    } finally {
      _$_ThemeConfigViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentColor(Color _) {
    final _$actionInfo = _$_ThemeConfigViewModelActionController.startAction(
        name: '_ThemeConfigViewModel.setCurrentColor');
    try {
      return super.setCurrentColor(_);
    } finally {
      _$_ThemeConfigViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pickerColor: ${pickerColor},
currentColor: ${currentColor}
    ''';
  }
}
