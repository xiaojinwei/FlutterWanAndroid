import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';

final persistor = new Persistor<AppState>(
    storage: new FlutterStorage(key:'basic-app'),
    serializer: JsonSerializer<AppState>(AppState.fromJson)
);

List<Middleware<AppState>> createMiddleware() => <Middleware<AppState>>[
  thunkMiddleware,
  persistor.createMiddleware(),
  LoggingMiddleware.printer(),
];