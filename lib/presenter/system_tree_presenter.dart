import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';

class SystemTreePresenter extends BasePresenter{

  StreamController<List<KnowledgeData>> treeController = StreamController<List<KnowledgeData>>();

  Stream<List<KnowledgeData>> get treeStream => treeController.stream;

  StreamController<List<NavigationData>> naviController = StreamController<List<NavigationData>>();

  Stream<List<NavigationData>> get naviStream => naviController.stream;

  Future requestTree(){
    return WanContainer().wanRepository.getTree()
        .then((value)=>treeController.sink.add(value))
        .catchError((e)=>treeController.sink.addError(e));
  }

  Future requestNavigation(){
    return WanContainer().wanRepository.getNavigation()
        .then((value)=>naviController.sink.add(value))
        .catchError((e)=>naviController.sink.addError(e));
  }

  @override
  void dispose() {
    treeController.close();
    naviController.close();
  }

}