import 'package:flutter/material.dart';
import 'package:flutter_dynamic/common/const.dart';
import 'package:flutter_dynamic/utils/util.dart';

class StatusViews extends StatelessWidget {
  const StatusViews(this.status, {Key key, this.onTap}) : super(key: key);
  final int status;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.fail:
        return new Container(
          width: double.infinity,
          child: new Material(
            color: Colors.white,
            child: new InkWell(
              onTap: () {
                onTap();
              },
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    Util.getImgPath("load_fail"),
                    width: 100,
                    height: 100,
                  ),
                  new Text(
                    "网络出问题了～ 请您查看网络设置",
                  ),
                  new Text(
                    "点击屏幕，重新加载",
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case LoadStatus.loading:
        return new Container(
          alignment: Alignment.center,
          color: Colors.grey,
          child: new ProgressView(),
        );
        break;
      case LoadStatus.empty:
        return new Container(
          color: Colors.white,
          width: double.infinity,
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  Util.getImgPath("load_no_data"),
                  width: 60,
                  height: 60,
                ),
                new Text(
                  "空空如也～",
                ),
              ],
            ),
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }
}

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 24.0,
        height: 24.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}