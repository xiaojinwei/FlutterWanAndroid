import 'package:flutter/material.dart';
import 'package:flutter_dynamic/utils/util.dart';

class ErrorPage extends StatefulWidget {

  final String errMsg;
  final String errDesc;

  ErrorPage({this.errMsg = '',this.errDesc = ''});

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 24,right: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Util.getImgPath("load_fail"),
                  width: 60,
                  height: 60,
                  color: Colors.red,
                ),
                Padding(padding: EdgeInsets.only(top: 8,bottom: 4),
                    child: Text(
                      widget.errMsg,
                      style: TextStyle(color: Colors.black87,fontSize: 14),
                ),),
                Padding(padding: EdgeInsets.only(top: 4,bottom: 8),
                child: Text(
                  widget.errDesc,
                  style: TextStyle(color: Colors.black54,fontSize: 12),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
