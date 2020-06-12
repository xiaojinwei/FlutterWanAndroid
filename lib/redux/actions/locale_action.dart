import 'dart:ui';

import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:redux/redux.dart';

class LocaleAction{
  Locale locale;

  LocaleAction({this.locale});
}

Function changeLocale = (Locale locale){
  return (Store<AppState> store){
    store.dispatch(LocaleAction(locale: locale));
  };
};