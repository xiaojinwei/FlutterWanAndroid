
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic/common/const.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/redux/models/theme_state.dart';
import 'package:flutter_dynamic/styles/colors.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'i18n_util.dart';

class ThemeUtil{
  static Color getThemeColor(BuildContext context){
    return StoreProvider.of<AppState>(context).state.themeState.themeColor;
  }

  static String getFontFamily(BuildContext context){
    return StoreProvider.of<AppState>(context).state.themeState.fontFamily;
  }

  static ThemeState getThemeState(BuildContext context){
    return StoreProvider.of<AppState>(context).state.themeState;
  }

  static String getThemeModeTitle(BuildContext context,int mode){
    switch(mode){
      case ThemeModeStatus.system:
        return I18nUtil.getS(context).theme_mode_auto;
      case ThemeModeStatus.light:
        return I18nUtil.getS(context).theme_mode_close;
      case ThemeModeStatus.dark:
        return I18nUtil.getS(context).theme_mode_open;
      default:
        return "";
    }
  }

  static List<ThemeModelLabel> getThemeModelLabels(BuildContext context){
    List<ThemeModelLabel> result = [
      ThemeModelLabel(title: getThemeModeTitle(context, ThemeModeStatus.system),mode: ThemeModeStatus.system,isSelected: isSelectedMode(context,ThemeModeStatus.system)),
      ThemeModelLabel(title: getThemeModeTitle(context, ThemeModeStatus.dark),mode: ThemeModeStatus.dark,isSelected: isSelectedMode(context,ThemeModeStatus.dark)),
      ThemeModelLabel(title: getThemeModeTitle(context, ThemeModeStatus.light),mode: ThemeModeStatus.light,isSelected: isSelectedMode(context,ThemeModeStatus.light)),
    ];
    return result;
  }

  static ThemeModelLabel getSelectedThemeModelLabel(BuildContext context){
    int mode = getThemeModeStatus(context);
    return ThemeModelLabel(title: getThemeModeTitle(context, mode),mode: mode,isSelected: isSelectedMode(context,mode));
  }

  static bool isSelectedMode(BuildContext context,int mode){
    return StoreProvider.of<AppState>(context).state.themeState?.themeMode == mode;
  }

  static Locale getSelectedLocale(BuildContext context){
    return StoreProvider.of<AppState>(context).state.locale;
  }

  static int getThemeModeStatus(BuildContext context){
    return StoreProvider.of<AppState>(context).state.themeState?.themeMode??0;
  }

  static ThemeMode getThemeMode(BuildContext context){
    final int theme = getThemeModeStatus(context);
    switch(theme) {
      case ThemeModeStatus.system:
        return ThemeMode.system;
      case ThemeModeStatus.light:
        return ThemeMode.light;
      case ThemeModeStatus.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static bool isDark(BuildContext context){
    return getThemeModeStatus(context) == ThemeModeStatus.dark;
  }

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getThemeColorWithDark(BuildContext context){
    bool isDark = ThemeUtil.isDarkMode(context);
    Color darkLightColor = Colours.dark_light_color;
    Color color = isDark ? darkLightColor : Theme.of(context).primaryColor;
    return color;
  }

  static Color getPrimaryColorWithDark(BuildContext context){
    bool isDark = ThemeUtil.isDarkMode(context);
    return isDark ? Theme.of(context).accentColor : Theme.of(context).primaryColor;
  }

  static ThemeData getTheme(BuildContext context,{bool isDarkMode = false}){
    var themeState = getThemeState(context);
    return ThemeData(
      primarySwatch: themeState?.themeColor,
      accentColor: themeState?.themeColor,
      fontFamily: themeState?.fontFamily,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }

}

class ThemeModelLabel {
  String title;
  int mode;
  bool isSelected;

  ThemeModelLabel({this.title,this.mode,this.isSelected});
}