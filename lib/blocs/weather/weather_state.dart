

import 'package:friendlyeats/src/model/weather.dart';

class WeatherState {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class InitializeWeatherState extends WeatherState {}

class WLoading extends WeatherState{}

class WeatherListSet extends WeatherState {
  final List<Weather> skyList;
  final List<Weather> tmpList;
  final List<Weather> humidList;
  final List<Weather> skyList_short;
  final List<Weather> tmpList_short;
  final List<Weather> humidList_short;

  const WeatherListSet(this.skyList, this.tmpList, this.humidList,
      this.skyList_short, this.tmpList_short, this.humidList_short);

  List<Object> get props =>
      [
        skyList,
        tmpList,
        humidList,
        skyList_short,
        tmpList_short,
        humidList_short
      ];

  @override
  String toString() {
    return '''WeatherListSet { 
    skyList : ${skyList.length}, 
    tmpList : ${tmpList.length}, 
    humidList : ${humidList.length}, 
    skyList_short : ${skyList_short.length}, 
    tmpList_short : ${tmpList_short.length}, 
    humidList_short : ${humidList_short.length},
    }''';
  }
}
