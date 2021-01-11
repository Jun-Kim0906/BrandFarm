//
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:friendlyeats/for_testing/test.dart';
//
// import 'blocs/blocObserver.dart';
//
//
// // Sets a platform override for desktop to avoid exceptions. See
// // https://flutter.dev/desktop#target-platform-override for more info.
// void _enablePlatformOverrideForDesktop() {
//   if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
//     debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
//   }
// }
//
// void main() async {
//   Bloc.observer = MyBlocObserver();
//   // Initialize Firebase
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   _enablePlatformOverrideForDesktop();
//
//   // notification
//   var initAndroidSetting = await AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initIosSetting = await IOSInitializationSettings();
//   var initSetting = await InitializationSettings(android: initAndroidSetting, iOS: initIosSetting);
//   await FlutterLocalNotificationsPlugin().initialize(initSetting);
//
//   runApp(
//     App()
//   );
// }
//
// class App extends StatefulWidget {
//   @override
//   _AppState createState() => _AppState();
// }
//
// class _AppState extends State<App> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return MaterialApp(
//       theme: ThemeData(),
//       home: Test(),
//     );
//   }
// }
