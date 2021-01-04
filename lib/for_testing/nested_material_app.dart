
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NestedMaterialApp extends StatefulWidget{
  NestedMaterialApp({Key key}) : super(key: key);

  @override
  _NestedMaterialAppState createState() => _NestedMaterialAppState();
}

class _NestedMaterialAppState extends State<NestedMaterialApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.blue,
      ),
      home: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.yellow,
          accentColor: Colors.red,
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, ),
              onPressed: (){Navigator.pop(context);},
            ),
            title: Text('nested materialApp example'),
          ),
          body: Container(
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
            child: Center(
              child: Text('color is',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  fontSize: 35,
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.android_outlined),
          ),
        ),
      ),
    );
  }
}