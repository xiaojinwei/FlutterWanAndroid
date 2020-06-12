import 'package:flutter_dynamic/redux/reducers/theme_reducer.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/redux/reducers/auth_reducer.dart';
import 'package:flutter_dynamic/redux/reducers/locale_reducer.dart';

AppState appReducer(AppState state,action){
  //if(action is PersistLoadedAction<AppState>){//PersistErrorAction,PersistLoadingAction
   // return action.state??state;
  //}else{
    return new AppState(
      authState: authReducer(state.authState,action),
      locale: localeReducer(state.locale, action),
      themeState: themeReducer(state.themeState,action)
    );
  //}
}