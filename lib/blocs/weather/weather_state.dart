import 'package:flutter/cupertino.dart';
//import 'package:friendlyeats/src/model/filter.dart';
import 'package:friendlyeats/src/model/restaurant.dart';
import 'package:friendlyeats/src/model/review.dart';
import 'package:meta/meta.dart';

class WeatherState {
  final bool isLoading;
  final List weatherInfo;

  WeatherState(
      {@required this.isLoading,
        @required this.weatherInfo,
      });

  factory WeatherState.empty() {
    return WeatherState(
      isLoading: false,
      weatherInfo: [],
    );
  }

  WeatherState copyWith({
    bool isLoading,
    List weatherInfo,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      weatherInfo: weatherInfo ?? this.weatherInfo,
    );
  }

  WeatherState update({
    bool isLoading,
    List weatherInfo,
  }) {
    return copyWith(
      isLoading: isLoading,
      weatherInfo: weatherInfo,
    );
  }

  @override
  String toString() {
    return '''WeatherState{
    isLoading: $isLoading,
    weatherInfo: ${weatherInfo.length},
    ''';
  }
}
