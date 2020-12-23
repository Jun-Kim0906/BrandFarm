
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlyeats/blocs/authentication_bloc/bloc.dart';


showAlertDialog(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  // set up the buttons
  Widget cancelButton = GestureDetector(
    child: AutoSizeText("아니요",maxLines: 1,),
    onTap: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = GestureDetector(
    child: AutoSizeText("네", style: TextStyle(color: Colors.blue), maxLines: 1,),
    onTap: () {
      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationLoggedOut(),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(20.0),
    // ),
    content: Container(
      height: height * 0.2,
      width: width,
//      padding: EdgeInsets.fromLTRB(width*0.005, height*0.005, width*0.005, height*0.005),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.04,
            child: AutoSizeText(
              '로그아웃',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          SizedBox(
            height: height * 0.03,
            width: width * 0.5,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text('정말로 로그아웃 하시겠습니까?'),
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          SizedBox(
            height: height * 0.03,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 1,
                  child: continueButton,
                ),
                SizedBox(width: width * 0.09,),
                Flexible(
                  flex: 1,
                  child: cancelButton,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
