import 'dart:math';

String getRandownNumber(int digits){
  return Random().nextInt(999999).toString().padLeft(digits, '0');
}

String generateAccountId(){
  return '#' + getRandownNumber(6);
}