import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String year = DateFormat('yyyy').format(now);
String month = DateFormat('MM').format(now);
String day = DateFormat('dd').format(now);
String hour = DateFormat('HH').format(now);
String minute = DateFormat('mm').format(now);
String weekday = daysOfWeek(index: now.weekday);

String daysOfWeek({int index, bool shorter = false}) {
  List<String> days = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"];
  return days.map((String day) {
    return shorter ? day.substring(0, 1) : day;
  }).toList()[index - 1];
}

String base_date = '$year$month$day';
String base_time = '$hour$minute';
List<String> villageFcstBT = ['02', '05', '08', '11', '14', '17', '20', '23'];

