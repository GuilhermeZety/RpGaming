import 'package:intl/intl.dart';

formatToTimeStamp(DateTime time){
  return DateFormat('yyyy/MM/dd').add_Hms().format(time);
}