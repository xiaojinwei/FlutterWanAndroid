
import 'package:flutter_dynamic/net/data/index.dart';

class User{
  final String token;
  final String id;
  final LoginData loginData;


  User({this.token,this.id,this.loginData});

  factory User.fromJson(Map<String,dynamic> json) =>
      new User(token: json['token'],id: json['id'],loginData: LoginData.fromJson(json['loginData']));

  Map<String,dynamic> toJson() => <String,dynamic>{
    'token':this.token,
    'id':this.id,
    'loginData':this.loginData?.toJson()
  };

  @override
  String toString() {
    return '''User{
            token: $token,
            id: $id,
            loginData:$loginData
        }''';
  }

}