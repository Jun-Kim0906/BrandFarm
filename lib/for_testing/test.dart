// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:flutter/material.dart';
import 'package:friendlyeats/for_testing/local_notification.dart';
import 'package:friendlyeats/for_testing/nested_material_app.dart';

import 'package:friendlyeats/src/chatting.dart';
import 'package:friendlyeats/src/connectivity.dart';
import 'package:friendlyeats/src/fcm.dart';
import 'package:friendlyeats/src/geolocator.dart';
import 'package:friendlyeats/src/hive_ex.dart';

import 'package:friendlyeats/for_testing/weather_icon.dart';

class Test extends StatefulWidget {

  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('testing menu'),
          actions: [
            PopupMenuButton(
                onSelected: (route) {
                  print(route);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => route),
                  );
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: GpsScreen(),
                    child: Text('gps'),
                  ),
                  PopupMenuItem(
                    value: ConnectivityPage(),
                    child: Text('internet'),
                  ),
                  PopupMenuItem(
                    value: FCM(),
                    child: Text('notify'),
                  ),
                  PopupMenuItem(
                    value: ChatScreen(),
                    child: Text('chat'),
                  ),
                  PopupMenuItem(
                    value: HiveEx(),
                    child: Text('Hive'),
                  ),
                  PopupMenuItem(
                    value: Weather_Icons(),
                    child: Text('weather icons'),
                  ),
                  PopupMenuItem(
                    value: LocalNotification(),
                    child: Text('local notification'),
                  ),
                ]),
          ],
        ),
        body: Center(
            child: Container(
              child: IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NestedMaterialApp()),
                  );
                },
                icon: Icon(Icons.android_outlined),
              ),
            ),
        ),
      );
  }
}
