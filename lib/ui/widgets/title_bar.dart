import 'package:flutter/material.dart';
import 'package:flutter_dynamic/ui/widgets/marquee_widget.dart';

class TitleBar extends StatefulWidget implements PreferredSizeWidget {

  Widget leftButton;
  String title = "";
  bool isShowBack = true;

  TitleBar({this.leftButton, this.title, this.isShowBack});

  @override
  _TitleBarState createState() => _TitleBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Theme.of(context).primaryColor.withAlpha(180),Theme.of(context).primaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
        )
      ),
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !widget.isShowBack,
            child: Container(
              alignment: Alignment.centerLeft,
              child: widget.leftButton == null
                  ? IconButton(
                      icon: Icon(Icons.arrow_back,color: Colors.white,),
                      onPressed: (){
                        Navigator.of(context).pop();
                      }
                ) : widget.leftButton,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: MarqueeWidget(
                text: widget.title,
                height: 56,
                width: MediaQuery.of(context).size.width - 90,
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
