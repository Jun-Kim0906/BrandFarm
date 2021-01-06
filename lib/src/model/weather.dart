import 'package:meta/meta.dart';

class Weather {
  final String baseDate;
  final String baseTime;
  final String category;
  final String fcstDate;
  final String fcstTime;
  final String fcstValue;
  final int nx;
  final int ny;

  Weather({
    @required this.baseDate,
    @required this.baseTime,
    @required this.category,
    @required this.fcstDate,
    @required this.fcstTime,
    @required this.fcstValue,
    @required this.nx,
    @required this.ny,
  });

  factory Weather.fromJson(Map<String, dynamic> ds) {
    return Weather(
      baseDate: ds['baseDate'].toString(),
      baseTime: ds['baseTime'].toString(),
      category: ds['category'].toString(),
      fcstDate: ds['fcstDate'].toString(),
      fcstTime: ds['fcstTime'].toString(),
      fcstValue: ds['fcstValue'].toString(),
      nx: ds['nx'],
      ny: ds['ny'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baseDate': baseDate,
      'baseTime': baseTime,
      'category': category,
      'fcstDate': fcstDate,
      'fcstTime': fcstTime,
      'fcstValue': fcstValue,
      'nx': nx,
      'ny': ny,
    };
  }
}