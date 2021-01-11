import 'package:flutter/material.dart';

class CTest extends StatefulWidget {
  @override
  _CTestState createState() => _CTestState();
}

class _CTestState extends State<CTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('component examples'),
      ),
      body: Container(),
    );
  }
}
