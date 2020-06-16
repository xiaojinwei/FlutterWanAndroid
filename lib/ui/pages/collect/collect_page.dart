import 'package:flutter/material.dart';
import 'package:flutter_dynamic/event/collect_event.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/collect_presenter.dart';
import 'package:flutter_dynamic/ui/state/base_collect_state.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends BaseCollectState<CollectPage> {
  final CollectPresenter presenter = CollectPresenter();

  RefreshController _controller = new RefreshController();

  @override
  void initState() {
    super.initState();
    presenter.onRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    presenter.dispose();
    super.dispose();
  }

  @override
  void onRefresh() {
    presenter.onRefresh();
  }

  @override
  void eventRefresh(CollectEvent event) {
    if(event.type == CollectEvent.TYPE_PART_REMOVE){
      //取消收藏直接移除该条目
      if("collect" == event.tag) //如果是收藏页的移除事件
        partRemoveRefresh(event);
    }else {
      super.eventRefresh(event);
    }
  }

  @override
  void partRefresh(event) {
    //改为整体刷新,当在收藏列表进入详情时，在详情取消收藏时调用
    if("collect" != event.tag) //ArticleItemWidget发出的局部刷新，不刷新
      presenter.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nUtil.getS(context).collect),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Article>>(
          stream: presenter.listStream,
          builder: (context,snapshot){
            return RefreshScaffold(
              loadStatus: Util.getLoadStatus(snapshot.hasError, snapshot.data),
              enablePullUp: true,
              controller: _controller,
              onRefresh: ({isReload}){
                return presenter.onRefresh();
              },
              onLoadMore: (){
                presenter.onLoadMore().then((value) => _controller.loadComplete())
                    .catchError((e)=>_controller.loadFailed());
              },
              itemCount:snapshot.hasData ? snapshot.data.length : 0,
              itemBuilder: (context,index){
                return ArticleItemWidget(snapshot.data[index],type: ArticleItemWidget.TYPE_COLLECT,);
              },
              error: snapshot.error,
            );
          }),
    );
  }
}
