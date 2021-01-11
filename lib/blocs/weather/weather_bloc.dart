import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:friendlyeats/blocs/weather/weather.dart';
import 'package:friendlyeats/src/data_repository/weather_repository.dart';
import 'package:friendlyeats/src/model/weather.dart';
import 'package:friendlyeats/src/utils/weather/api_addr.dart';
import 'package:friendlyeats/src/utils/weather/convert_grid_gps.dart';
import 'package:friendlyeats/src/utils/weather/datetime.dart';
import 'package:http/http.dart' as http;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.empty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherInfo) {
      yield* _mapGetWeatherInfoToState(event);
    } else if (event is Wait_Fetch_Weather){
      yield* _mapWait_Fetch_WeatherToState();
    }
  }

  Stream<WeatherState> _mapWait_Fetch_WeatherToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<WeatherState> _mapGetWeatherInfoToState(GetWeatherInfo event) async* {
    List weather_info;

    // testing values
    String str_lat = '36.1031';
    String str_lon = '129.3884';
    String base_date = '20210106';
    String base_time = '0500';

    double num_lat = double.parse(str_lat);
    double num_lon = double.parse(str_lon);

    LatXLngY point = convertGridGPS(0, num_lat, num_lon);
    int gridX = point.x;
    int gridY = point.y;


    http.Response weatherInfo;

    weatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$base_date&base_time=$base_time&nx=$gridX&ny=$gridY&');

    if (weatherInfo.statusCode == 200) {
      weather_info = await fetchWeatherInfo(weatherInfo);
    } else {
      throw Exception('Failed to fetch weather');
    }

    yield state.update(isLoading: false, weatherInfo: weather_info);
  }
}
