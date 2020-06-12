import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';
import 'base_collect_presenter.dart';

class RankPresenter extends BasePresenter {

  StreamController<List<RankData>> listController = StreamController<List<RankData>>();

  Stream<List<RankData>> get listStream => listController.stream;

  int _currentIndex = 1;

  List<RankData> rankList = [];

  Future onRefresh(){
    _currentIndex = 1;
    rankList.clear();
    return _request(_currentIndex);
  }

  Future onLoadMore(){
    return _request(_currentIndex);
  }

  Future _request(int num){
    return WanContainer().wanRepository.getRankList(num)
        .then((value){
      listController.sink.add(rankList..addAll(value));
      if(value.length > 0){
        _currentIndex ++;
      }
    });
  }

  @override
  void dispose() {
    listController.close();
  }

}