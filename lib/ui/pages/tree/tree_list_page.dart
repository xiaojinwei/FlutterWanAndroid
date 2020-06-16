import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/tree_list_presenter.dart';
import 'package:flutter_dynamic/ui/state/base_collect_state.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TreeListPage extends StatefulWidget {

  BaseTree base;

  TreeListPage(this.base);

  @override
  _TreeListPageState createState() => _TreeListPageState();
}

class _TreeListPageState extends BaseCollectState<TreeListPage> {

  final TreeListPresenter presenter = TreeListPresenter();

  RefreshController _controller = new RefreshController();


  @override
  void initState() {
    super.initState();
    presenter.cid = widget.base.id;
    presenter.onRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>(
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
                  .catchError(()=>_controller.loadFailed());
            },
            itemCount:snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (context,index){
              return ArticleItemWidget(snapshot.data[index],);
            },
            error: snapshot.error,
          );
        });
  }
}

