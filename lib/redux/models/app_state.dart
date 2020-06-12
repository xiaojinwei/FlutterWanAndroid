import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_dynamic/redux/models/auth_state.dart';
import 'package:flutter_dynamic/extension/locale_ext.dart';
import 'theme_state.dart';

@immutable
class AppState {

  final AuthState authState;

  /*
   * 国际化
   *
   * 设置为null，就相当于auto跟随系统，
   * 将locale持久化，让切换语言在关闭应用时也能生效
   *
   * 如果MaterialApp.locale设置为null或者不指定，
   * 那么会跟随系统的Locale从supportedLocales中找是否支持，
   * 不支持可以使用localeResolutionCallback来指定支持的Locale
   */
  final Locale locale;

  final ThemeState themeState;

  AppState({AuthState authState,Locale locale,ThemeState themeState}):
  this.authState = authState??new AuthState(),this.locale = locale,
  this.themeState = themeState??new ThemeState();

  static AppState fromJson(dynamic json) => json == null ? new AppState() : new AppState(
    authState: new AuthState.fromJson(json['authState']==null ? Map():json['authState']),
    locale: LocaleExtension.fromJson(json['locale']),
    themeState: ThemeState.fromJson(json['themeState'])
  );

  /// toJson名字固定
  Map<String,dynamic> toJson() => {
    'authState':authState.toJson(),
    'locale':locale == null ? null : locale.toJson(),
    'themeState':themeState.toJson()
  };

  @override
  String toString() {
    return '''AppState{
            authState: $authState,
            locale: $locale,
            themeState:$themeState
        }''';
  }

}