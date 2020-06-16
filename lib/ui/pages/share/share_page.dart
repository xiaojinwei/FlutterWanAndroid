import 'package:flutter/material.dart';
import 'package:flutter_dynamic/event/collect_event.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/share_presenter.dart';
import 'package:flutter_dynamic/ui/state/base_collect_state.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SharePage extends StatefulWidget {

  int userId;

  SharePage({this.userId});

  @override
  _SharePageState createState() => _SharePageState(userId: userId);
}

class _SharePageState extends BaseCollectState<SharePage> {

  int userId;

  _SharePageState({this.userId});

  final SharePresenter presenter = SharePresenter();

  RefreshController _controller = new RefreshController();

  @override
  void initState() {
    presenter.userId = userId;
    presenter.onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    presenter.dispose();
    super.dispose();
  }

  @override
  void eventRefresh(CollectEvent event) {
    if(event.type == CollectEvent.TYPE_PART_REMOVE){
      //取消收藏直接移除该条目
      if("share" == event.tag) //如果是分享页的移除事件
        partRemoveRefresh(event);
    }else {
      super.eventRefresh(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId == null ? I18nUtil.getS(context).my_share : I18nUtil.getS(context).user_share),
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
                return ArticleItemWidget(snapshot.data[index],type: _getArticleType(),);
              },
              error: snapshot.error,
            );
          }),
    );
  }

  int _getArticleType(){
    return userId == null ? ArticleItemWidget.TYPE_SHARE_MY : ArticleItemWidget.TYPE_SHARE_USER;
  }
}
