import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/search_presenter.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultView extends StatefulWidget {

  final String searchKey;
  SearchResultView({this.searchKey});

  @override
  _SearchResultViewState createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {

  final SearchPresenter presenter = SearchPresenter();

  RefreshController _controller = new RefreshController();

  @override
  void initState() {
    super.initState();
    presenter.searchKey = widget.searchKey;
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
    return Scaffold(
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
                return ArticleItemWidget(snapshot.data[index],type: ArticleItemWidget.TYPE_NORMAL,);
              },
            );
          }),
    );
  }
}
