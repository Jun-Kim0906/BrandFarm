
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
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.blue,
      ),
      home: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
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