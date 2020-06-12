import 'package:injector/injector.dart';

import 'net/repository/wan_repository.dart';

class WanContainer{
  static WanContainer _instance;

  final _injector = Injector();

  factory WanContainer() {
    if (_instance == null) {
      _instance = WanContainer._();
    }

    return _instance;
  }

  WanContainer._() {
    registerRepository();
  }

  void registerRepository() {
    _injector.registerSingleton<WanRepository>((injector) => WanRepository());
  }
  
  WanRepository get wanRepository {
    return _injector.getDependency<WanRepository>();
  }

}