import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';
import 'base_collect_presenter.dart';

class CoinPresenter extends BasePresenter {

  StreamController<List<CoinData>> listController = StreamController<List<CoinData>>();

  Stream<List<CoinData>> get listStream => listController.stream;

  int _currentIndex = 1;

  List<CoinData> rankList = [];

  Future onRefresh(){
    _currentIndex = 1;
    rankList.clear();
    return _request(_currentIndex);
  }

  Future onLoadMore(){
    return _request(_currentIndex);
  }

  Future _request(int num){
    return WanContainer().wanRepository.getCoinLgList(num)
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