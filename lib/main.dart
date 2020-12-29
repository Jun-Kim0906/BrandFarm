import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:friendlyeats/previews_main.dart';
import 'package:friendlyeats/src/app.dart';
import 'package:friendlyeats/src/chatting.dart';
import 'package:friendlyeats/src/connectivity.dart';
import 'package:friendlyeats/src/fcm.dart';
import 'package:friendlyeats/src/geolocator.dart';
import 'package:friendlyeats/src/home_page.dart';
import 'package:friendlyeats/test.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/blocObserver.dart';
import 'src/data_repository/user_repository/user_repository.dart';
import 'src/screens/login/login_screen.dart';
import 'src/app.dart' deferred as app;

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  Bloc.observer = MyBlocObserver();
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _enablePlatformOverrideForDesktop();

  runApp(
    App(),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    Timer(Duration(seconds: 3), () {
      _authenticationBloc.add(AuthenticationStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider.value(
            value: _authenticationBloc,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                backgroundColor: Colors.white,
                primaryColor: Colors.black,
                primaryColorLight: Colors.white,
                accentColor: Colors.blue[600],
                appBarTheme: AppBarTheme(brightness: Brightness.light),
              ),
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is AuthenticationSuccess) {
                    return FriendlyEatsApp(userRepository: userRepository,);
                    // return PreviewsMain(userRepository: userRepository);
                    // return Test();
                  } else if(state is AuthenticationFailure){
                    return LoginScreen(userRepository: userRepository);
                  } else if(state is AuthenticationInitial){
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                },
              ),
            ),
          );
  }

  @override
  void dispose() {
    _authenticationBloc.distinct();
    super.dispose();
  }

  final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData kDefaultTheme = ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );
}
