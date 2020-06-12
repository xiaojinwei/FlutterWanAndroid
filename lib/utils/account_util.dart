import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/redux/models/auth_state.dart';
import 'package:flutter_dynamic/redux/models/user.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../application.dart';
import 'cookie_util.dart';

class AccountUtil {
  static AuthState getAuthState(BuildContext context){
    return StoreProvider.of<AppState>(context).state.authState;
  }

  static User getUser(BuildContext context){
    return StoreProvider.of<AppState>(context).state.authState?.user;
  }

  static LoginData getLoginData(BuildContext context){
    return StoreProvider.of<AppState>(context).state.authState?.user?.loginData;
  }

  ///是否是登录状态
  static Future<bool> isLoginStatus({BuildContext context})async{
    var ctx = context??Application.instance.currentContext;
    if(ctx == null) return false;
    var userBool = getAuthState(ctx)?.isLoginStatus()??false;//用户信息
    var cookieBool = await CookieUtil.isExpired()??true;//cookie是否过期
    return userBool && !cookieBool;
  }

}