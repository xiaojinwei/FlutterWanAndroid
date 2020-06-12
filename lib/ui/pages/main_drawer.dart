import 'package:flutter/material.dart';
import 'package:flutter_dynamic/redux/actions/auth_actions.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/styles/colors.dart';
import 'package:flutter_dynamic/ui/widgets/dynamic_flutter_logo.dart';
import 'package:flutter_dynamic/ui/widgets/user_info.dart';
import 'package:flutter_dynamic/utils/account_util.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:flutter_dynamic/utils/string_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';


class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  static var _packageInfo = PackageInfo();
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtil.isDarkMode(context);
    Color darkLightColor = Colours.dark_light_color;
    return StoreConnector<AppState,dynamic>(
      converter: (store) => (BuildContext context){store.dispatch(logout(context));},
      builder: (context,logout) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,//去除Drawer灰色头部
          children: <Widget>[
            Container(
              child: DrawerHeader(
                padding: EdgeInsets.all(0),
                  decoration: new BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: UserAccountsDrawerHeader(
                    accountEmail: subView(),
                    accountName: Text(getTitle()),
                    onDetailsPressed: () {
                      var loginData = AccountUtil.getLoginData(context);
                      if(loginData != null) {
                        showDialog(context: context,
                            child: SimpleDialog(
                              title: Text('user info'), children: <Widget>[
                              UserInfoWidget(loginData),
                              SimpleDialogOption(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                        'close', style: TextStyle(color: Theme
                                          .of(context)
                                          .primaryColor),),
                                      onTap: () {
                                        NavigatorUtil.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],));
                      }else{
                        NavigatorUtil.gotoLogin(context);
                      }
                    },
                    currentAccountPicture: CircleAvatar(
                      child: DynamicFlutterLogo(54.0),
                    ),
                  )
              ),
            ),
            ListTile(
              title: Text(I18nUtil.getS(context).wenda),
              leading: Icon(Icons.question_answer,color: isDark ? darkLightColor : Theme.of(context).primaryColor),
              onTap: (){
                NavigatorUtil.pop(context);
                NavigatorUtil.gotoWenDa(context);
              },
            ),
            ListTile(
              title: Text(I18nUtil.getS(context).square),
              leading: Icon(Icons.surround_sound,color: isDark ? darkLightColor : Theme.of(context).primaryColor),
              onTap: (){
                NavigatorUtil.pop(context);
                NavigatorUtil.gotoSquare(context);
              },
            ),
            ListTile(
              title: Text(I18nUtil.getS(context).collect),
              leading: Icon(Icons.favorite,color: isDark ? darkLightColor : Theme.of(context).primaryColor),
              onTap: (){
                NavigatorUtil.pop(context);
                NavigatorUtil.gotoCollect(context);
              },
            ),
            ListTile(
              title: Text(I18nUtil.getS(context).share),
              leading: Icon(Icons.share,color: isDark ? darkLightColor : Theme.of(context).primaryColor),
              onTap: (){
                NavigatorUtil.pop(context);
                NavigatorUtil.gotoShare(context);
              },
            ),
            ListTile(
              title: Text(I18nUtil.getS(context).ranking),
              leading: Icon(Icons.looks_one,color: isDark ? darkLightColor : Theme.of(context).primaryColor),
              onTap: (){
                NavigatorUtil.pop(context);
                NavigatorUtil.gotoRank(context);
              },
            ),
            Divider(),
            AboutListTile(
              applicationName: _packageInfo.appName,
              applicationLegalese: 'Copyright © cj',
              applicationVersion: _packageInfo.version,
              applicationIcon: Icon(Icons.info),
              icon: Icon(Icons.info,color: isDark ? darkLightColor : Theme.of(context).primaryColor,),
              aboutBoxChildren: <Widget>[
                new Text("1.xxx"),
                new Text("2.xxx")
              ]
            ),
            ListTile(
              title: Text(I18nUtil.getS(context).setting),
              leading: Icon(Icons.settings,color: isDark ? darkLightColor : Theme.of(context).primaryColor),
              onTap: (){
                NavigatorUtil.pop(context);
                NavigatorUtil.gotoSetting(context);
              },
            ),
            Divider(),
            _logOutInView(context,logout, isDark ? darkLightColor : Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  _logOutInView(context,logout,color){
    return AccountUtil.getAuthState(context)?.isLoginStatus()??false ?
    ListTile(
      title: Text(I18nUtil.getS(context).log_out),
      leading: Icon(Icons.exit_to_app,color: color),
      onTap: ()=>logout(context),
    )
        :
    ListTile(
      title: Text(I18nUtil.getS(context).log_in),
      leading: Icon(Icons.open_in_browser,color: color),
      onTap: ()=>NavigatorUtil.gotoLogin(context),
    );
  }

  getTitle(){
    var loginData = AccountUtil.getLoginData(context);
    if(StringUtil.isNotEmpty(loginData?.nickname)) return loginData?.nickname??"";
    return loginData?.username??"";
  }

  subView(){
    return StoreConnector<AppState,Store<AppState>>(
      converter:  (Store<AppState> store) => store,
      builder: (context,store){
        var rank = store.state.authState?.rankData;
        if(rank == null){
          AccountUtil.isLoginStatus().then((value){
            if(value) {
              store.dispatch(coin());
            }
          });
          return Container(height: 10,);
        }
        return InkWell(
          onTap: () => NavigatorUtil.gotoCoin(context),
          child: Container(
            child: Row(
              children: <Widget>[
                Text(
                    I18nUtil.getS(context).level + ": " + rank?.rank?.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  I18nUtil.getS(context).integral + ": " + rank?.coinCount?.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
