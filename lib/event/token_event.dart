import 'package:flutter_dynamic/net/data/index.dart';

class TokenEvent{
  LoginData loginData;

  TokenEvent({this.loginData});

  static TokenEvent createTokenEvent(LoginData loginData){
    return TokenEvent(loginData: loginData);
  }
}