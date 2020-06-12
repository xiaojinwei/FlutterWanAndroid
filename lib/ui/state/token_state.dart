import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic/event/token_event.dart';
import 'package:flutter_dynamic/utils/bus_util.dart';

abstract class TokenState<T extends StatefulWidget> extends State<T>{

  StreamSubscription<TokenEvent> _subscriptionToken;

  @override
  void initState() {
    initTokenBus();
    super.initState();
  }

  @override
  void dispose() {
    _subscriptionToken?.cancel();
    super.dispose();
  }

  void onRefresh(){}

  void initTokenBus() {
    _subscriptionToken = BusUtil.eventBus.on<TokenEvent>().listen((event) {
      if(event.loginData != null){
        onRefresh();
      }
    });
  }
}