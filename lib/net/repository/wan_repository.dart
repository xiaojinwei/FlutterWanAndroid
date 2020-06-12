import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/net/dio/http_dio.dart';
import 'package:sprintf/sprintf.dart';

import '../api.dart';

class WanRepository{
  Future<List<BannerData>> getBanner() async {
    var reps = await HttpDio.instance.get(Api.BANNER_URL);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<BannerData> result = [];
    reps.data.forEach((e){
      result.add(BannerData.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getTopArticle() async{
    var reps = await HttpDio.instance.get(Api.ARTICLE_TOP);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getArticleList(int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.HOME_ARTICLE_LIST,[num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future collect(int id) async {
    var resp = await HttpDio.instance.post(sprintf(Api.COLLECT,[id]));
    if(!resp.isSuccess()){
      return Future.error(resp.msg);
    }
    return Future.value();
  }

  Future unCollectOriginId(int id) async {
    var resp = await HttpDio.instance.post(sprintf(Api.UN_COLLECT_ORIGIN_ID,[id]));
    if(!resp.isSuccess()){
      return Future.error(resp.msg);
    }
    return Future.value();
  }

  Future<List<TabLabel>> getProjectTab()async{
    var reps = await HttpDio.instance.get(Api.PROJECT_TAB);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<TabLabel> result = [];
    reps.data?.forEach((e){
      result.add(TabLabel.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getProjectList(int num,int cid) async{
    var reps = await HttpDio.instance.get(sprintf(Api.PROJECT_LIST,[num,cid]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future<List<TabLabel>> getWeChatTab()async{
    var reps = await HttpDio.instance.get(Api.WECHAT_TAB);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<TabLabel> result = [];
    reps.data?.forEach((e){
      result.add(TabLabel.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getWebChatList(int id,int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.WECHAT_LIST,[id,num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future<List<KnowledgeData>> getTree()async{
    var reps = await HttpDio.instance.get(Api.TREE);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<KnowledgeData> result = [];
    reps.data?.forEach((e){
      result.add(KnowledgeData.fromJson(e));
    });
    return result;
  }

  Future<List<NavigationData>> getNavigation()async{
    var reps = await HttpDio.instance.get(Api.NAVIGATION);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<NavigationData> result = [];
    reps.data?.forEach((e){
      result.add(NavigationData.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getTreeList(int num,int cid) async{
    var reps = await HttpDio.instance.get(sprintf(Api.TREE_LIST,[num,cid]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getWenDaList(int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.WENDA_LIST,[num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getSquareList(int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.SQUARE_LIST,[num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future<LoginData> login(String username,String password)async{
    var reps = await HttpDio.instance.post(Api.LOGIN,data: FormData.fromMap({'username':username,'password':password}));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    var result = LoginData.fromJson(reps.data);
    return result;
  }

  Future<LoginData> register(String username,String password,String repassword)async{
    var reps = await HttpDio.instance.post(Api.REGISTER,data: FormData.fromMap({'username':username,'password':password,'repassword':repassword}));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    var result = LoginData.fromJson(reps.data);
    return result;
  }

  Future<List<Article>> getCollectList(int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.COLLECT_LIST,[num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

  Future<RankData> getCoinInfo()async{
    var reps = await HttpDio.instance.get(Api.COIN_INFO,);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    var result = RankData.fromJson(reps.data);
    return result;
  }

  Future<List<RankData>> getRankList(int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.RANK_LIST,[num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<RankData> result = [];
    reps.data['datas']?.forEach((e){
      result.add(RankData.fromJson(e));
    });
    return result;
  }

  Future<List<CoinData>> getCoinLgList(int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.COIN_LG_LIST,[num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<CoinData> result = [];
    reps.data['datas']?.forEach((e){
      result.add(CoinData.fromJson(e));
    });
    return result;
  }

  Future<ShareArticles> getShareList(int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.SHARE_ARTICLE_LIST,[num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    var result = ShareArticles.fromJson(reps.data);
    return result;
  }

  Future addShare(String title,String link) async {
    var resp = await HttpDio.instance.post(Api.SHARE_ARTICLE,data: FormData.fromMap({"title":title,"link":link}));
    if(!resp.isSuccess()){
      return Future.error(resp.msg);
    }
    return Future.value();
  }

  Future<ShareArticles> getUserShareList(int userId,int num) async{
    var reps = await HttpDio.instance.get(sprintf(Api.SHARE_ARTICLE_USER,[userId,num]));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    var result = ShareArticles.fromJson(reps.data);
    return result;
  }

  Future deleteShare(int articleId) async {
    var resp = await HttpDio.instance.post(sprintf(Api.SHARE_ARTICLE_DELETE,[articleId]));
    if(!resp.isSuccess()){
      return Future.error(resp.msg);
    }
    return Future.value();
  }

  Future<List<HotKey>> getHotKey()async{
    var reps = await HttpDio.instance.get(Api.HOT_KEY);
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<HotKey> result = [];
    reps.data?.forEach((e){
      result.add(HotKey.fromJson(e));
    });
    return result;
  }

  Future<List<Article>> getSearchList(String k,int num) async{
    var reps = await HttpDio.instance.post(sprintf(Api.SEARCH_RESULT_LIST,[num]),data: FormData.fromMap({"k":k}));
    if(!reps.isSuccess()){
      return Future.error(reps.msg);
    }
    List<Article> result = [];
    reps.data['datas']?.forEach((e){
      result.add(Article.fromJson(e));
    });
    return result;
  }

}