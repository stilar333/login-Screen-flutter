import 'package:intl/intl.dart';

class CodeGen {

   String getCode(){
DateTime currDt = DateTime.now();
var code = currDt.year.toString()+currDt.month.toString()+currDt.day.toString()+currDt.hour.toString()+currDt.minute.toString()+currDt.second.toString();
return code;
  }
}