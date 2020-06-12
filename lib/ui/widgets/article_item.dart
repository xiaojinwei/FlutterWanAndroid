import 'package:flutter/material.dart';
import 'package:flutter_dynamic/event/collect_event.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/article_collect_presenter.dart';
import 'package:flutter_dynamic/ui/widgets/stroke_widget.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:flutter_dynamic/utils/string_util.dart';
import 'package:flutter_dynamic/utils/bus_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';

import 'article_title.dart';

class ArticleItemWidget extends StatefulWidget {

  static const int TYPE_NORMAL = 0; //正常是显示❤️，点击收藏文章
  static const int TYPE_COLLECT = 1; //收藏页显示的是删除图标，点击删除收藏
  static const int TYPE_SHARE_MY = 2; //我的分享页显示的是删除图标和❤️，点击删除分享，和点击收藏
  static const int TYPE_SHARE_USER = 3; //分享人分享页显示的是❤️，点击收藏

  Article article;
  final int type;

  ArticleItemWidget(this.article,{this.type = TYPE_NORMAL});
  
  @override
  _ArticleItemWidgetState createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {

  var presenter = ArticleCollectPresenter();

  Article article;
  @override
  Widget build(BuildContext context) {
    article = widget.article;
    Color color = ThemeUtil.getThemeColorWithDark(context);
    return GestureDetector(
      onTap: (){
        NavigatorUtil.webView(context, article.link,title: article.title,id: _id(),isCollect: _isCollect());
      },
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 8, 10, 4),
          child:  Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Icon(StringUtil.isEmpty(article.author) ? Icons.folder_shared : Icons.person,
                            size: 20,color: color,),
                          Container(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(StringUtil.isEmpty(article.author) ? article.shareUser??"" : article.author??"",
                              maxLines: 1,style: Theme.of(context).textTheme.caption,),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Offstage(
                              offstage: !(article.fresh ?? true),
                              child: StrokeWidget(I18nUtil.getS(context).new_article,fontSize: 10.0,color: color,),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Offstage(
                              offstage: (article.type??0) == 0 ?? false,
                              child: StrokeWidget(I18nUtil.getS(context).top,fontSize: 10.0,color: color,),
                            ),
                          )
                        ],
                      )
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.access_time,
                          color: Theme.of(context).iconTheme.color.withAlpha(120),size: 20,),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(article.niceDate,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,),
                        )
                      ],
                    ),
                  )
                ],
              ),
              article.envelopePic?.isEmpty ?
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: ArticleTitleWidget(article.title),
                ),
              ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          ArticleTitleWidget(article.title),
                          SizedBox(height: 2,),
                          Text(article.desc,
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 2,)
                        ],
                      )
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Image.network(
                      article.envelopePic,
                      height: 80,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(_joinString(article.chapterName,article.superChapterName),
                          style: TextStyle(
                              color: color,
                              fontSize: 11.0
                          ),),
                      )
                  ),
                  _rightActionView()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _id(){
    return widget.type == ArticleItemWidget.TYPE_COLLECT ? article.originId : article.id;
  }

  _isCollect(){
    return widget.type == ArticleItemWidget.TYPE_COLLECT ? true : article.collect??false;
  }

  _rightActionView(){
    switch(widget.type){
      case ArticleItemWidget.TYPE_NORMAL:
      case ArticleItemWidget.TYPE_SHARE_USER:
        return _favoriteViewAction(() => _collect());
      case ArticleItemWidget.TYPE_COLLECT:
        return _deleteViewAction(() => _deleteCollect());
      case ArticleItemWidget.TYPE_SHARE_MY:
        return Row(
          children: <Widget>[
            _favoriteViewAction(() => _collect()),
            _deleteViewAction(() => _deleteShare())
          ],
        );
    }
  }

  _deleteViewAction(VoidCallback onPressed){
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 5),
        icon: Icon(
          Icons.delete_forever,
          color: Colors.red,
        ),
        onPressed: onPressed,
      ),
    );
  }

  _favoriteViewAction(VoidCallback onPressed){
    return Align(
      alignment: Alignment.centerRight,
      child: !(article.collect??false) ?
      IconButton(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 4),
        icon: Icon(Icons.favorite_border,color: Colors.black45,),
        onPressed: onPressed,
      ) :
      IconButton(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 4),
        icon: Icon(Icons.favorite,color: Colors.red,),
        onPressed: onPressed,
      ),
    );
  }

  _joinString(String str1,String str2){
    if(StringUtil.isEmpty(str1)) return str2??"";
    if(StringUtil.isEmpty(str2)) return str1??"";
    return "${str1}/${str2}";
  }

  _deleteCollect(){
    presenter.unCollect(article.originId, (value){
      BusUtil.eventBus.fire(CollectEvent.createPartRemoveEvent(article.id, false,tag: "collect"));//刷新收藏页,article.id就是收藏页的article.id
      BusUtil.eventBus.fire(CollectEvent.createPartEvent(article.originId, false,tag: "collect"));//刷新其他有该id的文章列表页，其他页面的article.id是收藏article.originId
    }, (e){
      print(e);
    });
  }

  _collect() {
    if(article.collect == null || article.id == null) return;
    !article.collect ? presenter.collect(article.id, (value){
      setState(() {
        article.collect = !article.collect;
      });
    }, (e){
      print(e);
    }) : presenter.unCollect(article.id, (value){
      setState(() {
        article.collect = !article.collect;
      });
    }, (e){
      print(e);
    });
  }

  _deleteShare(){
    if(article.id == null) return;
    presenter.deleteShare(article.id, (value){
      BusUtil.eventBus.fire(CollectEvent.createPartRemoveEvent(article.id, false,tag: "share"));
    }, (e){
      print(e);
    });
  }
}
