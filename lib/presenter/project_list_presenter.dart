import 'dart:async';

import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';
import 'base_collect_presenter.dart';

class ProjectListPresenter extends BasePresenter implements BaseCollectPresenter{

  ProjectListPresenter({int cid}):_cid=cid;

  StreamController<List<Article>> listController = StreamController<List<Article>>();

  Stream<List<Article>> get listStream => listController.stream;

  int _currentIndex = 0;

  List<Article> articleList = [];
  
  int _cid;
  
  set cid(int cid) => _cid = cid;

  Future onRefresh(){
    _currentIndex = 0;
    articleList.clear();
    return _request(_currentIndex);
  }

  Future onLoadMore(){
    return _request(_currentIndex);
  }

  Future _request(int num){
    return WanContainer().wanRepository.getProjectList(num,_cid)
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