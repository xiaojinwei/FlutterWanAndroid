import 'package:flutter/material.dart';
import 'package:flutter_dynamic/event/collect_event.dart';
import 'package:flutter_dynamic/event/token_event.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/redux/models/user.dart';
import 'package:flutter_dynamic/utils/bus_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:redux/redux.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';

import '../../container.dart';
import 'package:flutter_dynamic/utils/cookie_util.dart';

class UserLoginRequest {}

class UserLoginSuccess {
  User user;

  UserLoginSuccess(this.user);
}

class UserLoginFailure {
  String error;

  UserLoginFailure({this.error});
}

class UserLogout{}

class UserRegisterRequest {}

class UserRegisterSuccess {
  User user;

  UserRegisterSuccess(this.user);
}

class UserRegisterFailure {
  String error;

  UserRegisterFailure({this.error});
}

class UserCoinSuccess {
  RankData rankData;

  UserCoinSuccess({this.rankData});
}

final Function login = (BuildContext context,String username,String password){
  return (Store<AppState> store)async{
    store.dispatch(new UserLoginRequest());
    WanContainer().wanRepository.login(username, password).then((value){
      store.dispatch(new UserLoginSuccess(new User(token:'token__token',id:'id__id',loginData: value)));
      NavigatorUtil.gotoMainOrBack(context);
      BusUtil.eventBus.fire(TokenEvent.createTokenEvent(value));
      BusUtil.eventBus.fire(CollectEvent.createRefreshEvent());
    }).catchError((e){
      store.dispatch(new UserLoginFailure(error:e.toString()));
    });
  };
};

final Function logout = (BuildContext context){
  return (Store<AppState> store){
    store.dispatch(new UserLogout());
    CookieUtil.deleteAllCookies();
    NavigatorUtil.gotoLoginRemoveUntil(context);
  };
};

final Function register = (BuildContext context,String username,String password,String repassword){
  return (Store<AppState> store)async{
    store.dispatch(new UserRegisterRequest());
    WanContainer().wanRepository.register(username, password,repassword).then((value){
      store.dispatch(new UserRegisterSuccess(new User(token:'token__token',id:'id__id',loginData: value)));
      NavigatorUtil.gotoMainRemoveUntil(context);
    }).catchError((e){
      store.dispatch(new UserRegisterFailure(error:e.toString()));
    });
  };
};

final Function coin = (){
  return (Store<AppState> store)async{
    WanContainer().wanRepository.getCoinInfo().then((value){
      store.dispatch(new UserCoinSuccess(rankData: value));
    });
  };
};