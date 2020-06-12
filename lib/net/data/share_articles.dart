import 'package:flutter_dynamic/net/data/index.dart';

class ShareArticles {
  RankData coinInfo;
  ShareArticlesItem shareArticles;

  ShareArticles.fromJson(Map<String, dynamic> json) {
    coinInfo = json['coinInfo'] != null ? RankData.fromJson(json['coinInfo']) : null;
    shareArticles = json['shareArticles'] != null ? ShareArticlesItem.fromJson(json['shareArticles']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinInfo'] = coinInfo?.toJson();
    data['shareArticles'] = shareArticles?.toJson();
    return data;
  }
}

class ShareArticlesItem{
  int curPage;
  List<Article> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ShareArticlesItem.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
    datas = json['datas'] != null ? Article.parseList(json['datas']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}