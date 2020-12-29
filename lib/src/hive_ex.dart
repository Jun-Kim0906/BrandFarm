import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendlyeats/src/screens/hive_ex/dark_mode_switch.dart';

class HiveEx extends StatefulWidget{

  HiveEx({Key key}) : super(key: key);

  @override
  _HiveExState createState() => _HiveExState();
}

class _HiveExState extends State<HiveEx> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Examples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          scrollDirection: Axis.horizontal, //스크롤 방향 조절
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 6, //로우 혹은 컬럼수 조절 (필수값)
          children: <Widget>[
            Card(
              color: Colors.blue[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridTile(
                  header: Text('header'),
                  footer: Text('footer'),
                  child: InkResponse(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DarkModeSwitch()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}