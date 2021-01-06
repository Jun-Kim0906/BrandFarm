

import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  const WeatherEvent();

  List<Object> get props => [];
}

class WeatherLoading extends WeatherEvent{}

class GetWeather extends WeatherEvent{
  final String fid;
  final String nx;
  final String ny;

  const GetWeather({this.fid, this.ny, this.nx});

  List<Object> get props => [fid, ny, nx];

  @override
  String toString() => 'GetWeather { fid : $fid, nx : $nx, ny : $ny }';
}