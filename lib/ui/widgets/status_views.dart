import 'package:flutter/material.dart';
import 'package:flutter_dynamic/common/const.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/string_util.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:flutter/foundation.dart';

class StatusViews extends StatelessWidget {
  const StatusViews(this.status, {Key key, this.onTap,this.error}) : super(key: key);
  final int status;
  final String error;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.fail:
        return new Container(
          width: double.infinity,
          child: new Material(
            //color: Colors.white,
            child: new InkWell(
              onTap: () {
                onTap();
              },
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    Util.getImgPath("load_fail"),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
                    child: new Text(
                      I18nUtil.getS(context).network_error_hint,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                    child:  new Text(
                      I18nUtil.getS(context).click_reload,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  kDebugMode && StringUtil.isNotEmpty(this.error) ?
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 8),
                    child:  new Text(
                      this.error,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                  ) : Container()
                ],
              ),
            ),
          ),
        );
        break;
      case LoadStatus.loading:
        return new Container(
          alignment: Alignment.center,
          //color: Colors.grey,
          child: new ProgressView(),
        );
        break;
      case LoadStatus.empty:
        return new Container(
          //color: Colors.white,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child:  new Text(
                    I18nUtil.getS(context).empty_hint,
                    textAlign: TextAlign.center,
                  ),
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