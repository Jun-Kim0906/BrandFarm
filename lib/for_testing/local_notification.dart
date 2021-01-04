import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {

  @override
  void initState() {
    super.initState();
    // notification
    // var initAndroidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initIosSetting = IOSInitializationSettings();
    // var initSetting = InitializationSettings(android: initAndroidSetting, iOS: initIosSetting);
    // await FlutterLocalNotificationsPlugin().initialize(initSetting);
    showScheduledNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('local notification'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: showNotification,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: showScheduledNotification,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    await FlutterLocalNotificationsPlugin().show(0, 'title', 'body', platform);
  }

  Future<void> showScheduledNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    await FlutterLocalNotificationsPlugin().schedule(0, 'title', 'body', DateTime.parse('2020-04-15 13:02:00'), platform);
  }
}