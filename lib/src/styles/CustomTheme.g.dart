// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomTheme.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomTheme on _CustomThemeBase, Store {
  late final _$themeAtom =
      Atom(name: '_CustomThemeBase.theme', context: context);

  @override
  ThemeData get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(ThemeData value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  late final _$_CustomThemeBaseActionController =
      ActionController(name: '_CustomThemeBase', context: context);

  @override
  void setTheme(ThemeData _) {
    final _$actionInfo = _$_CustomThemeBaseActionController.startAction(
        name: '_CustomThemeBase.setTheme');
    try {
      return super.setTheme(_);
    } finally {
      _$_CustomThemeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
theme: ${theme}
    ''';
  }
}
