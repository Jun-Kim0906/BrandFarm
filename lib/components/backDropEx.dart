import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

class BackDropEx extends StatefulWidget {
  @override
  _BackDropExState createState() => _BackDropExState();
}

class _BackDropExState extends State<BackDropEx> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Backdrop Example"),
        actions: <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          )
        ],
      ),
      backLayer: Center(
        child: Text("Back Layer"),
      ),
      subHeader: BackdropSubHeader(
        title: Text("Sub Header"),
      ),
      frontLayer: Center(
        child: Text("Front Layer"),
      ),
    );
  }
}
