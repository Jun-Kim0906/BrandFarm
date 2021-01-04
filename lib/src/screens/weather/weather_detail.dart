import 'package:flutter/material.dart';
import 'package:friendlyeats/src/utils/unicode.dart';

class WeatherDetail extends StatefulWidget {
  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
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
        title: Text('한규네 딸기농장'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        '16',
                        style: TextStyle(fontSize: 64, color: Colors.white),
                      ),
                      Text(
                        '맑음',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '2022-04-07',
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                '경상북도 포항시',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              '일몰',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            circle('오후 6:31'),
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
                            circle('10%'),
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
                            circle('0 cm'),
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
                            circle('29%'),
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
                            circle('2 m/s'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.4,
                  ),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         shrinkWrap: true,
                  //           physics: ClampingScrollPhysics(),
                  //           itemCount: 24,
                  //           itemBuilder: (context, index) =>
                  //             col('오후 9시', 'sunny', '16'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0x49FFFFFF),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(150)),
            ),
          ),
          Container(
            width: 70,
            height: 70,
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

  Widget circle(String info) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Color(0x20FFFFFF),
        shape: BoxShape.circle,
      ),
      child: FittedBox(
          child: Text(
        info,
        style: TextStyle(color: Colors.white),
      )),
    );
  }

  Widget col(String time, String icon, String temp) {
    return Container(
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            Icons.wb_sunny_outlined,
            color: Colors.white,
          ),
          Text(temp + degrees + 'C', style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}
