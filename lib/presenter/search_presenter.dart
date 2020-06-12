import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';
import 'base_collect_presenter.dart';

class SearchPresenter extends BasePresenter implements BaseCollectPresenter{

  StreamController<List<Article>> listController = StreamController<List<Article>>();

  Stream<List<Article>> get listStream => listController.stream;

  int _currentIndex = 0;

  List<Article> articleList = [];

  String searchKey;

  //List<HotKey> hotKeys = [];

  Future onRefresh(){
    _currentIndex = 0;
    articleList.clear();
    return _request(_currentIndex);
  }

  Future onLoadMore(){
    return _request(_currentIndex);
  }

  Future _request(int num){
    return WanContainer().wanRepository.getSearchList(searchKey,num)
        .then((value){
      listController.sink.add(articleList..addAll(value));
      if(value.length > 0){
        _currentIndex ++;
      }
    });
  }

  Future<List<HotKey>> getHotKey(){
    return WanContainer().wanRepository.getHotKey();
  }

  @override
  void dispose() {
    listController.close();
  }

}