import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';
import 'base_collect_presenter.dart';

class CollectPresenter extends BasePresenter implements BaseCollectPresenter{

  StreamController<List<Article>> listController = StreamController<List<Article>>();

  Stream<List<Article>> get listStream => listController.stream;

  int _currentIndex = 0;

  List<Article> articleList = [];

  Future onRefresh(){
    _currentIndex = 0;
    articleList.clear();
    return _request(_currentIndex);
  }

  Future onLoadMore(){
    return _request(_currentIndex);
  }

  Future _request(int num){
    return WanContainer().wanRepository.getCollectList(num)
        .then((value){
          listController.sink.add(articleList..addAll(value));
          if(value.length > 0){
            _currentIndex ++;
          }
        }).catchError((e){
          listController.sink.addError(e);
        });
  }

  @override
  void dispose() {
    listController.close();
  }

}