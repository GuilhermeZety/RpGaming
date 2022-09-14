import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

formatToTimeStamp(DateTime time){
  return DateFormat('yyyy/MM/dd').add_Hms().format(time);
}

MaterialStateProperty<Color?> createMaterialStateProperty(Color color){
  return MaterialStateProperty.all<Color?>(color);
}

formatDateToddMMyyyy(DateTime date){
  return DateFormat('dd/MM/yyyy').format(date);
}