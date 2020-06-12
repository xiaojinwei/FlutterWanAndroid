import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';

class OfficialAccountPresenter extends BasePresenter{

  StreamController<List<TabLabel>> tabController = StreamController<List<TabLabel>>();

  Stream<List<TabLabel>> get tabStream => tabController.stream;

  Future getOfficialAccountTab(){
    return WanContainer().wanRepository.getWeChatTab()
        .then((value) => tabController.sink.add(value));
  }

  @override
  void dispose() {
    tabController.close();
  }

}