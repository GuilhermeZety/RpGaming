// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load-viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoadViewModel on _LoadViewModel, Store {
  late final _$initAtom = Atom(name: '_LoadViewModel.init', context: context);

  @override
  bool get init {
    _$initAtom.reportRead();
    return super.init;
  }

  @override
  set init(bool value) {
    _$initAtom.reportWrite(value, super.init, () {
      super.init = value;
    });
  }

  late final _$showLogoAtom =
      Atom(name: '_LoadViewModel.showLogo', context: context);

  @override
  bool get showLogo {
    _$showLogoAtom.reportRead();
    return super.showLogo;
  }

  @override
  set showLogo(bool value) {
    _$showLogoAtom.reportWrite(value, super.showLogo, () {
      super.showLogo = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_LoadViewModel.position', context: context);

  @override
  double get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(double value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$durationAnimateWaveAtom =
      Atom(name: '_LoadViewModel.durationAnimateWave', context: context);

  @override
  int get durationAnimateWave {
    _$durationAnimateWaveAtom.reportRead();
    return super.durationAnimateWave;
  }

  @override
  set durationAnimateWave(int value) {
    _$durationAnimateWaveAtom.reportWrite(value, super.durationAnimateWave, () {
      super.durationAnimateWave = value;
    });
  }

  late final _$anguloAtom =
      Atom(name: '_LoadViewModel.angulo', context: context);

  @override
  double get angulo {
    _$anguloAtom.reportRead();
    return super.angulo;
  }

  @override
  set angulo(double value) {
    _$anguloAtom.reportWrite(value, super.angulo, () {
      super.angulo = value;
    });
  }

  late final _$_LoadViewModelActionController =
      ActionController(name: '_LoadViewModel', context: context);

  @override
  void setInit(bool _) {
    final _$actionInfo = _$_LoadViewModelActionController.startAction(
        name: '_LoadViewModel.setInit');
    try {
      return super.setInit(_);
    } finally {
      _$_LoadViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowLogo(bool _) {
    final _$actionInfo = _$_LoadViewModelActionController.startAction(
        name: '_LoadViewModel.setShowLogo');
    try {
      return super.setShowLogo(_);
    } finally {
      _$_LoadViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPosition(double _) {
    final _$actionInfo = _$_LoadViewModelActionController.startAction(
        name: '_LoadViewModel.setPosition');
    try {
      return super.setPosition(_);
    } finally {
      _$_LoadViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDurationAnimateWave(int _) {
    final _$actionInfo = _$_LoadViewModelActionController.startAction(
        name: '_LoadViewModel.setDurationAnimateWave');
    try {
      return super.setDurationAnimateWave(_);
    } finally {
      _$_LoadViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAngulo(double _) {
    final _$actionInfo = _$_LoadViewModelActionController.startAction(
        name: '_LoadViewModel.setAngulo');
    try {
      return super.setAngulo(_);
    } finally {
      _$_LoadViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
init: ${init},
showLogo: ${showLogo},
position: ${position},
durationAnimateWave: ${durationAnimateWave},
angulo: ${angulo}
    ''';
  }
}
