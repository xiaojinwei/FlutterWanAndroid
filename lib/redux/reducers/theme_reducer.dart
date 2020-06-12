
import 'package:flutter_dynamic/redux/actions/theme_action.dart';
import 'package:flutter_dynamic/redux/models/theme_state.dart';
import 'package:redux/redux.dart';

Reducer<ThemeState> themeReducer = combineReducers([
  new TypedReducer<ThemeState,ThemeColorAction>(changeThemeReducer),
  new TypedReducer<ThemeState,FontFamilyAction>(changeFontFamilyReducer),
  new TypedReducer<ThemeState,ThemeModeAction>(changeThemeModeReducer),
]);

ThemeState changeThemeReducer(ThemeState themeState,ThemeColorAction action){
  return themeState.copyWith(
    themeColor: action.color
  );
}

ThemeState changeFontFamilyReducer(ThemeState themeState,FontFamilyAction action){
  return themeState.copyWith(
      fontFamily: action.fontFamily
  );
}

ThemeState changeThemeModeReducer(ThemeState themeState,ThemeModeAction action){
  return themeState.copyWith(
      themeMode: action.mode
  );
}