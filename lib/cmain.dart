
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:friendlyeats/components/ctest.dart';

void main() async {
  runApp(
      App()
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: CTest(),
    );
  }
}
