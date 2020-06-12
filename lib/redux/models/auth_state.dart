import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/redux/models/user.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final User user;
  final String error;

  ///注册时的状态，不持久化
  final bool isRegistering;
  ///积分信息，不持久化
  final RankData rankData;

  AuthState({this.isAuthenticated = false,this.isAuthenticating = false,
  this.user,this.error,this.isRegistering = false,this.rankData});

  factory AuthState.fromJson(Map<String,dynamic> json) => new AuthState(
    isAuthenticated: json['isAuthenticated']??false,
    isAuthenticating: json['isAuthenticating']??false,
    user: json['user'] == null ? null : User.fromJson(json['user']),
  //  error: json['error']??''
  );

  Map<String,dynamic> toJson() => <String,dynamic>{
    'isAuthenticated':this.isAuthenticated,
    'isAuthenticating':this.isAuthenticating,
    'user':this.user == null ? null : this.user.toJson(),
  //  'error':this.error
  };

  AuthState copyWith({
    bool isAuthenticated,
    bool isAuthenticating,
    User user,
    String error,
    bool isRegistering,
    RankData rankData,
  }){
    return new AuthState(
      isAuthenticating: isAuthenticating??this.isAuthenticating,
      isAuthenticated: isAuthenticated??this.isAuthenticated,
      user: user??this.user,
      error: error??this.error,
      isRegistering: isRegistering??this.isRegistering,
      rankData: rankData??this.rankData,
    );
  }

  bool isLoginStatus(){
    return isAuthenticated && user != null;
  }

  @override
  String toString() {
    return '''AuthState{
            isAuthenticated: $isAuthenticated,
            isAuthenticating: $isAuthenticating,
            user: $user,
            error: $error,
            isRegistering: $isRegistering,
            rankData：$rankData,
        }''';
  }

}