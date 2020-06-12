import 'package:flutter/material.dart';

class Application{
  BuildContext _context;
  BuildContext _currentContext;

  get context => _context;

  set context(context) => _context = context;

  static Application _instance;

  static Application get instance => _getInstance();

  factory Application() => _getInstance();

  Application._internal(){

  }

  static Application _getInstance() {
    if(_instance == null){
      _instance = new Application._internal();
    }
    return _instance;
  }

  get currentContext => _currentContext;

  set currentContext(context) => _currentContext = context;
}