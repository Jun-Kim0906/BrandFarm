import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const darkModeBox = 'darkModeTutorial';

class DarkModeSwitch extends StatefulWidget {
  DarkModeSwitch({Key key}) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}
class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool initializeBox = false;

  @override
  void initState() {
    super.initState();
    _initializeHive().then((result) {
      setState(() {
        initializeBox = result;
      });
    });
  }

  Future<bool> _initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox(darkModeBox);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return initializeBox ? ValueListenableBuilder(
      valueListenable: Hive.box(darkModeBox).listenable(),
      builder: (context, box, widget) {
        var darkMode = box.get('darkMode', defaultValue: false);
        return MaterialApp(
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white,),
                onPressed: () async {
                  // await box.close();
                  await Hive.close();
                  Navigator.pop(context);
                },
              ),
              title: Text('Dark Mode Switch with Hive'),
            ),
            body: Center(
              child: Switch(
                value: darkMode,
                onChanged: (val) {
                  box.put('darkMode', !darkMode);
                },
              ),
            ),
          ),
        );
      },
    ) : CircularProgressIndicator();
  }
}