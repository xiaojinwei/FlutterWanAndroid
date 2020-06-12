import 'package:flutter/material.dart';
import 'package:flutter_dynamic/common/const.dart';
import 'package:flutter_dynamic/extension/color_ext.dart';

class ThemeState {
  MaterialColor themeColor;//主题
  String fontFamily;//字体
  int themeMode;//主题模式，暗黑模式
  
  ThemeState({MaterialColor themeColor,String fontFamily,int themeMode}):
        this.themeColor = themeColor??Colors.purple,
        this.fontFamily = fontFamily??Const.supportFontFamily[0],
        this.themeMode = themeMode??ThemeModeStatus.system;

  factory ThemeState.fromJson(Map<String,dynamic> json) => ThemeState(
      themeColor:ColorExtension.fromJson(json == null ? null : json['themeColor']),
      fontFamily:json == null ? null : json['fontFamily'],
      themeMode:json == null ? null : json['themeMode']
  );

  Map<String,dynamic> toJson() => <String,dynamic>{
    'themeColor': themeColor == null ? null : themeColor.toJson(),
    'fontFamily': fontFamily,
    'themeMode': themeMode,
  };

  ThemeState copyWith({
    MaterialColor themeColor,
    String fontFamily,
    int themeMode
  }){
    return new ThemeState(
        themeColor: themeColor??this.themeColor,
        fontFamily: fontFamily??this.fontFamily,
        themeMode: themeMode??this.themeMode
    );
  }

  @override
  String toString() {
    return '''ThemeState{
            themeColor: $themeColor,
            fontFamily: $fontFamily,
            themeMode: $themeMode,
        }''';
  }
}