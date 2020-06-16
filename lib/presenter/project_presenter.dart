import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';

class ProjectPresenter extends BasePresenter{

  StreamController<List<TabLabel>> projectTabController = StreamController<List<TabLabel>>();

  Stream<List<TabLabel>> get projectTabStream => projectTabController.stream;

  Future getProjectTab(){
    return WanContainer().wanRepository.getProjectTab()
        .then((value) => projectTabController.sink.add(value))
        .catchError((e) => projectTabController.sink.addError(e));
  }

  @override
  void dispose() {
    projectTabController.close();
  }

}