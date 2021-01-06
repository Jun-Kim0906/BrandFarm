import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:friendlyeats/blocs/weather/weather.dart';
import 'package:friendlyeats/src/model/weather.dart';
import 'package:friendlyeats/src/utils/weather/api_addr.dart';
import 'package:friendlyeats/src/utils/weather/convert_grid_gps.dart';
import 'package:friendlyeats/src/utils/weather/datetime.dart';
import 'package:http/http.dart' as http;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(InitializeWeatherState());

  // @override
  // WeatherState get initialState => InitializeWeatherState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeather) {
      yield* _mapGetWeatherToState(event);
    } else if (event is WeatherLoading){
      yield* _mapWeatherLoadingToState();
    }
  }

  Stream<WeatherState> _mapWeatherLoadingToState() async* {
    yield WLoading();
  }

  Stream<WeatherState> _mapGetWeatherToState(GetWeather event) async* {
    print(
        '//////////////////////////////// Weather API Start ///////////////////////////////////////');
    List<Weather> skyList = [];
    List<Weather> tmpList = [];
    List<Weather> humidList = [];

    List<Weather> skyList_short = [];
    List<Weather> tmpList_short = [];
    List<Weather> humidList_short = [];

    String nx = event.nx;
    String ny = event.ny;
    print('nx : $nx, ny : $ny');

    double la = double.parse(event.nx);
    double lo = double.parse(event.ny);
    print('la : $la, lo : $lo');

    LatXLngY point = convertGridGPS(0, la, lo);
    int gridX = point.x;
    int gridY = point.y;
    print('gridX : $gridX, gridY : $gridY');

    String bb;
    String bb_short;
    String bt;
    String bt_short;

    print('base date: ' + base_date);
    print('hour: $hour, minute: $minute');
//    DateTime testDateTimeNow = DateTime.parse("20200723T093000");
//    String btTest = DateFormat('HHmm').format(testDateTimeNow);
//    print('btTest: ' + btTest);

    /// short fcst info
    if (int.parse(minute) > 30) {
      bt_short = hour + '30';
      bb_short = base_date;
    } else if (int.parse(minute) == 30) {
      bt_short = hour + '00';
      bb_short = base_date;
    } else if (int.parse(minute) < 30) {
      int tempHour = int.parse(hour) - 1;
      if (tempHour < 0) {
        bt_short = '2330';
        int tempDay = int.parse(day) - 1;
        if(tempDay < 10) {
          bb_short = year + month + '0' + tempDay.toString();
        } else {
          bb_short = year + month + tempDay.toString();
        }
      } else {
        (tempHour.toString().length < 2)
            ? bt_short = '0' + tempHour.toString() + '30'
            : bt_short = tempHour.toString() + '30';
        bb_short = base_date;
      }
    } else {
      throw Exception('[if-else] Failed to load short fcst weather');
    }
    print('bt_short : ' + bt_short);
    print('bb_short : ' + bb_short);

    http.Response shortWeatherInfo;

    shortWeatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$bb_short&base_time=$bt_short&nx=$gridX&ny=$gridY&');

    if (shortWeatherInfo.statusCode == 200) {
      json
          .decode(shortWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "REH") {
          humidList_short.add(Weather.fromJson(data));
        } else if (data['category'] == "SKY") {
          skyList_short.add(Weather.fromJson(data));
        } else if (data['category'] == "T1H") {
          tmpList_short.add(Weather.fromJson(data));
        } else {
          ;
        }
      });
    } else {
      throw Exception('[category] Failed to load short fcst weather');
    }

    String startingTemp = tmpList_short[0].fcstValue;
    String startingTime = tmpList_short[0].fcstTime;

    print(
        'Starting item of short fcst list { starting temperature : $startingTemp, starting time : $startingTime }');

    /// village weather info
    /// base_time : 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300
    villageFcstBT.forEach((time) {
      if (int.parse(hour) >= 00 && int.parse(hour) < 02) {
        bt = '2000';
        int tempDay = int.parse(day) - 1;
        if(tempDay < 10) {
          bb = year + month + '0' + tempDay.toString();
        } else {
          bb = year + month + tempDay.toString();
        }
      } else if (int.parse(hour) >= 02 && int.parse(hour) <= 05) {
        bt = '2300';
        int tempDay = int.parse(day) - 1;
        if(tempDay < 10) {
          bb = year + month + '0' + tempDay.toString();
        } else {
          bb = year + month + tempDay.toString();
        }
      } else if (int.parse(hour) > 23 && int.parse(hour) < 24) {
        bt = '2000';
        bb = base_date;
      } else if (int.parse(hour) <= int.parse(time)) {
        if (bb == null) {
          int index = villageFcstBT.indexOf(time);
          bt = villageFcstBT[index - 1] + '00';
          bb = base_date;
          print('index : $index');
        } else {
          ; //skip
        }
      } else if(int.parse(hour) > int.parse(time)) {
        ; // skip
      } else {
        throw Exception('[if-else] Problem has occured in getting village API { time : $base_time, date : $base_date }');
      }
    });

    print('bt : ' + bt);
    print('bb : ' + bb);

    http.Response villageWeatherInfo;

    villageWeatherInfo = await http
        .get('$villageFcstHeader&base_date=$bb&base_time=$bt&nx=$gridX&ny=$gridY&');

    if (villageWeatherInfo.statusCode == 200) {
      json
          .decode(villageWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "REH") {
          humidList.add(Weather.fromJson(data));
        } else if (data['category'] == "SKY") {
          skyList.add(Weather.fromJson(data));
        } else if (data['category'] == "T3H") {
          tmpList.add(Weather.fromJson(data));
        } else {
          ;
        }
      });
    } else {
      throw Exception('[category] Failed to load village weather');
    }

    print(
        '////////////////////// Finished Getting Weather API ///////////////////////////////////');

    yield WeatherListSet(skyList, tmpList, humidList, skyList_short,
        tmpList_short, humidList_short);
  }
}
