import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendlyeats/src/utils/unicode.dart';

enum weather_circle_type { sunset, prob_of_precip, precip, humidity, wind_info }

class WeatherDetail extends StatefulWidget {
  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  String fieldName = '한동이네 딸기 농장';
  String curr_addr = '경상북도 포항시';
  String curr_temp = '16' + degrees;
  String maxTemp = '18';
  String minTemp = '8';
  String sunset = '6:31';
  String prob_of_precip = '10';
  String precip = '0';
  String humidity = '29';
  String wind_dir = '서남서';
  String wind_speed = '2';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          fieldName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.location_on,
            color: Colors.white,
            size: 14,
          ),
          Center(
              child: Text(
            curr_addr,
            style: TextStyle(fontSize: 12),
          )),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.1032,
                  0.3218,
                  0.4822,
                  0.6571,
                  0.7919,
                ],
                colors: [
                  Color(0xFF82BFED),
                  Color(0xFF80D0F6),
                  Color(0xFF6BDCFF),
                  Color(0xFFADEBFF),
                  Color(0xFF7BE7FF),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          print('refresh button pressed');
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '맑음',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        '16' + degrees,
                        style: TextStyle(fontSize: 70, color: Colors.white),
                      ),
                      Container(
                        width: 107,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '최고: ' + maxTemp + degrees,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              '최저: ' + minTemp + degrees,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              '일몰',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            circle(
                                info: sunset, type: weather_circle_type.sunset),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              '강수확률',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            circle(
                                info: prob_of_precip,
                                type: weather_circle_type.prob_of_precip),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              '강수량',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            circle(
                                info: precip, type: weather_circle_type.precip),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              '습도',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            circle(
                                info: humidity,
                                type: weather_circle_type.humidity),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              '바람',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            circle(
                                info: wind_speed,
                                type: weather_circle_type.wind_info),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.4,
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: 24,
                            itemBuilder: (context, index) {
                              if(index == 0) {
                                return Row(
                                  children: [
                                    horizontal_view(time: '지금', icon: 'sunny', temp: '16', now: 1),
                                    SizedBox(width: 20,),
                                  ],
                                );
                              } else {
                                return Row(
                                  children: [
                                    horizontal_view(time: '오후 9시', icon: 'sunny', temp: '16', now: 0),
                                    SizedBox(width: 20,),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.4,
                  ),
                  Container(
                    height: 235,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 24,
                      itemBuilder: (context, index) {
                        return vertical_view(date: '화요일', icon: '흐림', info: '18', info2: '6',);
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.4,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Color(0x49FFFFFF),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(150)),
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0x30FFFFFF),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(150)),
            ),
          ),
        ],
      ),
    );
  }

//  enum weather_circle_type {sunset, prob_of_precip, precip, humidity, wind_info}

  Widget circle({String info, weather_circle_type type}) {
    switch (type) {
      case weather_circle_type.sunset:
        {
          return circleStyle_row(info: '오후 ', info2: info, font_size: 15);
        }
        break;
      case weather_circle_type.prob_of_precip:
        {
          return circleStyle_gradient(
              info: info, info2: '%', font_size: 24, font_size2: 15);
        }
        break;
      case weather_circle_type.precip:
        {
          return circleStyle_row(
              info: info, info2: ' cm', font_size: 24, font_size2: 15);
        }
        break;
      case weather_circle_type.humidity:
        {
          return circleStyle_gradient(
              info: info, info2: '%', font_size: 24, font_size2: 15);
        }
        break;
      case weather_circle_type.wind_info:
        {
          return circleStyle_col(
              info: '서남서', info2: info + 'm/s', font_size: 15);
        }
        break;
      default:
        {
          return circleStyle_row(
              info: '-', info2: '-', font_size: 15, font_size2: 15);
        }
        break;
    }
  }

  Widget circleStyle_gradient(
      {String info, String info2, double font_size, double font_size2}) {
    var top = double.parse(info);
    var bottom = 100 - top;
    var top_dec = top / 100;
    var bottom_dec = bottom / 100;
    print('$top, $bottom, $top_dec, $bottom_dec');
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
//        color: Color(0x20FFFFFF),
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [top_dec, bottom_dec],
          colors: [
            Color(0x20FFFFFF),
            Color(0xFF75BDFF),
          ],
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              info,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              info2,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleStyle_row(
      {String info, String info2, double font_size, double font_size2}) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Color(0x20FFFFFF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              info,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              info2,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleStyle_col(
      {String info, String info2, double font_size, double font_size2}) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Color(0x20FFFFFF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              info,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              info2,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // if now = 1 then now . . . else if now == 0 then not now
  Widget horizontal_view({String time, String icon, String temp, int now}) {
    return Container(
      // width: 25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          now == 0
              ? Text(time, style: TextStyle(color: Colors.white),)
              : Text(time, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          // SizedBox(height: 10,),
          Icon(
            Icons.wb_sunny_outlined,
            color: Colors.yellow,
          ),
          // SizedBox(height: 10,),
          Row(
            children: [
              Text(
                temp,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                celcius,
                style: TextStyle(fontSize: 8.0,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget vertical_view({String date, String icon, String info, String info2}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: TextStyle(color: Colors.white),),
          Icon(Icons.cloud_rounded, color: Colors.grey,),
          Row(
            children: [
              Text(info, style: TextStyle(color: Colors.white),),
              SizedBox(width: 25,),
              Text(info2, style: TextStyle(color: Colors.white),),
            ],
          ),
        ],
      ),
    );
  }
}
