import 'package:redux/redux.dart';
import 'package:flutter_dynamic/redux/reducers/app_reducer.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/redux/middleware/middleware.dart';

Store<AppState> createStore(AppState initialState){

  Store<AppState> store = new Store(
    appReducer,
    initialState: initialState ?? new AppState(),
    middleware: createMiddleware()
  );

  return store;
}