
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlyeats/blocs/weather/weather.dart';
import 'package:friendlyeats/src/screens/weather/weather_detail.dart';
import 'package:friendlyeats/src/utils/unicode.dart';

class WeatherMain extends StatefulWidget {
  @override
  _WeatherMainState createState() => _WeatherMainState();
}

class _WeatherMainState extends State<WeatherMain> {
  // ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0);

  String fieldName = '한동이네 딸기 농장';
  String curr_addr = '경상북도 포항시';
  String curr_temp = '16' + degrees;
  String maxTemp = '18';
  String minTemp = '8';
  var height;
  var width;

  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF37949B),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(fieldName, style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF37949B)),),
        actions: [
          Icon(Icons.location_on, color: Colors.black,),
          Center(child: Text(curr_addr, style: TextStyle(color: Colors.black),)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherDetail()),
                  );
                },
                child: Container(
                  width: width,
                  height: 282,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.0611,
                        0.3129,
                        0.5495,
                      ],
                      colors: [
                        Color(0xFF82BFED),
                        Color(0xFF80D0F6),
                        Color(0xFF7EDFFE),
                      ],
                    ),
                  ),
                  child: ListView(
                    children: [
                      Container(
                        height: 18.64,
                        child: Row(
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
                      ),
                      Column(
                        children: [
                          Text(
                            '맑음',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            curr_temp,
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
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeatherDetail()),
                    );
                  },
                  child: Container(
                    width: width,
                    height: 113,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0x9037949B),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CupertinoScrollbar(
                              // controller: _scrollController,
                              // isAlwaysShown: true,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: Color(0x49FFFFFF),
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(150)),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0x30FFFFFF),
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(150)),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

}