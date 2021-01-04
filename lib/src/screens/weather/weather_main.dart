
import 'package:flutter/material.dart';
import 'package:friendlyeats/src/screens/weather/weather_detail.dart';

class WeatherMain extends StatefulWidget {
  @override
  _WeatherMainState createState() => _WeatherMainState();
}

class _WeatherMainState extends State<WeatherMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('한규네 딸기농장'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1032,
                0.3437,
                0.5696,
                0.7919,
              ],
              colors: [
                Color(0xFF82BFED),
                Color(0xFF80D0F6),
                Color(0xFF7EDFFE),
                Color(0xFFA1E9FF),
              ],
            ),
          ),
          child: Container(
            child: Card(
              child: GestureDetector(
                  child: Text('More Details'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherDetail()),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

}