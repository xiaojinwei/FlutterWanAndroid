import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';
import 'base_collect_presenter.dart';

class SharePresenter extends BasePresenter implements BaseCollectPresenter {

  
  SharePresenter({int userId}):this._userId = userId;

  StreamController<List<Article>> listController = StreamController<List<Article>>();

  Stream<List<Article>> get listStream => listController.stream;

  int _currentIndex = 1;

  List<Article> articleList = [];

  RankData rankData;
  
  int _userId;

  set userId(userId) => _userId = userId;

  Future onRefresh(){
    _currentIndex = 1;
    articleList.clear();
    return _request(_currentIndex);
  }

  Future onLoadMore(){
    return _request(_currentIndex);
  }

  Future _request(int num){
    return _getFuture(num)
        .then((value){
          rankData = value.coinInfo;
          listController.sink.add(articleList..addAll(value.shareArticles?.datas));
          if((value?.shareArticles?.datas?.length??0) > 0){
            _currentIndex ++;
          }
        }).catchError((e){
          listController.sink.addError(e);
        });
  }
  
  Future _getFuture(int num){
      return _userId != null?
      WanContainer().wanRepository.getUserShareList(_userId,num) :
      WanContainer().wanRepository.getShareList(num);
  }

  @override
  void dispose() {
    listController.close();
  }

}