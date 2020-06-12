import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';

import '../container.dart';
import 'base_presenter.dart';
import 'base_collect_presenter.dart';

class HomePresenter extends BasePresenter implements BaseCollectPresenter{
  StreamController<List<BannerData>> homeBannerController = StreamController<List<BannerData>>();
  StreamController<List<Article>> homeArticleController = StreamController<List<Article>>();
  
  int _currentIndex = 0;

  List<Article> articleList = [];

  StreamBuilder<List<BannerData>> bannerStream = null;
  List<BannerData> bannerList = [];

  Future onRefresh(){
    _currentIndex = 0;
    articleList.clear();
    _requestBanner();
    return _requestTopArticle();
  }

  Future onLoadMore(){
    return _requestArticleList(_currentIndex);
  }

  Future _requestBanner(){
    return WanContainer().wanRepository.getBanner()
        .then((value) => homeBannerController.sink.add(value));
  }

  Future _requestTopArticle(){
    return WanContainer().wanRepository.getTopArticle()
        .then((value){
          homeArticleController.sink.add(articleList..addAll(value));
          _requestArticleList(_currentIndex);
        });
  }

  Future _requestArticleList(int num){
    return WanContainer().wanRepository.getArticleList(num)
        .then((value){
          homeArticleController.sink.add(articleList..addAll(value));
          if(value.length > 0){
            _currentIndex ++;
          }
        });
  }
  
  Stream<List<BannerData>> get homeBannerStream => homeBannerController.stream.asBroadcastStream();
  
  Stream<List<Article>> get homeArticleStream => homeArticleController.stream;

  @override
  void dispose() {
    homeBannerController.close();
    homeArticleController.close();
  }



}