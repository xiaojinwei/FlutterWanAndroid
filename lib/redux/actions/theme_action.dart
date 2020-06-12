import 'package:flutter/material.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:redux/redux.dart';

class ThemeColorAction{
  MaterialColor color;

  ThemeColorAction({this.color});
}

class FontFamilyAction{
  String fontFamily;

  FontFamilyAction({this.fontFamily});
}

class ThemeModeAction {
  int mode;

  ThemeModeAction({this.mode});
}

Function changeThemeColor = (MaterialColor color){
  return (Store<AppState> store){
    store.dispatch(ThemeColorAction(color: color));
  };
};

Function changeFontFamily = (String fontFamily){
  return (Store<AppState> store){
    store.dispatch(FontFamilyAction(fontFamily: fontFamily));
  };
};

Function changeThemeMode = (int mode){
  return (Store<AppState> store){
    store.dispatch(ThemeModeAction(mode: mode));
  };
};