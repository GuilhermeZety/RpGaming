import 'dart:async';

import 'package:mobx/mobx.dart';

part 'load_viewmodel.g.dart';

class LoadViewModel = _LoadViewModelBase with _$LoadViewModel;

abstract class _LoadViewModelBase with Store {
  @observable
  bool init = false;
  @action 
  void setInit(bool _) => init = _;

  @observable
  bool showLogo = false;
  @action 
  void setShowLogo(bool _) => showLogo = _;

  @observable
  double position = -5000;
  @action 
  void setPosition(double _) => position = _;

  @observable
  int durationAnimateWave = 8000;
  @action 
  void setDurationAnimateWave(int _) => durationAnimateWave = _;

  @observable
  double angulo = 0;
  @action 
  void setAngulo(double _) => angulo = _;

  load() async {
    init = true;
    position = 0;
      
    Timer(Duration(milliseconds: durationAnimateWave - 2000), () => setShowLogo(true));
    Timer(Duration(milliseconds: durationAnimateWave), () {
      Timer.periodic(const Duration(milliseconds: 3000), (timer) { 
        setAngulo(angulo + 4/ 8);
        setDurationAnimateWave(3000);
        setNewPosition();
      });
    });
  }

  setNewPosition(){
    if(position == 0){
      setPosition(-1000);
    }
    else if(position == -1000){
      setPosition(0);
    }
  }
}

