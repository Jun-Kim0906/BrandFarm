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
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlyeats/blocs/weather/weather.dart';
import 'package:friendlyeats/for_testing/local_notification.dart';
import 'package:friendlyeats/for_testing/nested_material_app.dart';
import 'package:friendlyeats/layout/adaptive.dart';

import 'package:friendlyeats/src/chatting.dart';
import 'package:friendlyeats/src/connectivity.dart';
import 'package:friendlyeats/src/fcm.dart';
import 'package:friendlyeats/src/geolocator.dart';
import 'package:friendlyeats/src/hive_ex.dart';

import 'package:friendlyeats/for_testing/weather_icon.dart';
import 'package:friendlyeats/src/screens/weather/weather_main.dart';

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  final isWindowMobile = isDisplayMobile;
  ScrollController _hideButtonController;
  AnimationController _hideAnimationController;
  bool _isVisible;
  final items = List<ListItem>.generate(
    1200,
        (i) => i % 6 == 0
        ? HeadingItem("Heading $i")
        : MessageItem("Sender $i", "Message body $i"),
  );

  @override
  void initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideAnimationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1,
    );
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          _hideAnimationController.reverse();
          /* only set when the previous state is false
             * Less widget rebuilds
             */
          print('**** ${_isVisible} up'); //Move IO away from setState
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            _hideAnimationController.forward();
            /* only set when the previous state is false
               * Less widget rebuilds
               */
            print('**** ${_isVisible} down'); //Move IO away from setState
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testing menu'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NestedMaterialApp()),
              );
            },
            icon: Icon(Icons.android_outlined),
          ),
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
                    // PopupMenuItem(
                    //   value: HiveEx(),
                    //   child: Text('Hive'),
                    // ),
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
      body: Container(
        child: ListView.builder(
          controller: _hideButtonController,
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
      ),
      floatingActionButton: FadeTransition(
        opacity: _hideAnimationController,
        child: ScaleTransition(
          scale: _hideAnimationController,
          child: fab(context),
        ),
      ),
      // Visibility(
      //   visible: _isVisible,
      //   child: fab(context),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget fab (BuildContext context) { return Container(
    child: SizedBox(
      width: 210,
      height: 50,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.android_outlined),
                onPressed: () {
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.wb_sunny_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlocProvider(
                      create: (BuildContext context) => WeatherBloc(),
                      child: WeatherMain(),
                    ),),
                  );
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.android_outlined),
                onPressed: () {
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.android_outlined),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
      ),
    ),
  ); }

  Widget myFabButton = Container(
    color: Colors.blue,
    width: 200.0,
    height: 50.0,
    child: Row(
      children: [
        RawMaterialButton(
          shape: RoundedRectangleBorder(),
          elevation: 3.0,
          child: Icon(
            Icons.favorite,
          ),
          onPressed: () {},
        ),
        RawMaterialButton(
          shape: RoundedRectangleBorder(),
          elevation: 3.0,
          child: Icon(
            Icons.favorite,
          ),
          onPressed: () {},
        ),
        RawMaterialButton(
          shape: RoundedRectangleBorder(),
          elevation: 3.0,
          child: Icon(
            Icons.favorite,
          ),
          onPressed: () {},
        ),
        RawMaterialButton(
          shape: RoundedRectangleBorder(),
          elevation: 3.0,
          child: Icon(
            Icons.favorite,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );

  @override
  void dispose() {
    _hideButtonController.removeListener(() { });
    _hideButtonController.dispose();
    _hideAnimationController.dispose();
    super.dispose();
  }
}
