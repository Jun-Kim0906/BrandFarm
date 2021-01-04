import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Weather_Icons extends StatefulWidget{
  Weather_Icons({Key key}) : super(key: key);

  @override
  _Weather_IconsState createState() => _Weather_IconsState();
}

class _Weather_IconsState extends State<Weather_Icons> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('weather icons list'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text('day_sunny'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.day_sunny),
                SizedBox(height: 10,),
                Text('rain'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.rain),
                SizedBox(height: 10,),
                Text('cloud'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.cloud),
                SizedBox(height: 10,),
                Text('day_cloudy'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.day_cloudy),
                SizedBox(height: 10,),
                Text('cloudy'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.cloudy),
                SizedBox(height: 10,),
                Text('snow'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.snow),
                SizedBox(height: 10,),
                Text('fog'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.fog),
                SizedBox(height: 10,),
                Text('cloudy_gusts'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.cloudy_gusts),
                SizedBox(height: 10,),
                Text('lightning'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.lightning),
                SizedBox(height: 10,),
                Text('thunderstorm'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.thunderstorm),
                SizedBox(height: 10,),
                Text('rain_mix'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.rain_mix),
                SizedBox(height: 10,),
                Text('cloudy_windy'),
                SizedBox(height: 10,),
                Icon(WeatherIcons.cloudy_windy),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}