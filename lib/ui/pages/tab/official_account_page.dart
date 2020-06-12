import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/official_account_list_presenter.dart';
import 'package:flutter_dynamic/presenter/official_account_presenter.dart';
import 'package:flutter_dynamic/ui/state/base_collect_state.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/ui/widgets/status_views.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfficialAccountPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _OfficialAccountPageState();
  }
}

class _OfficialAccountPageState extends State<OfficialAccountPage> with TickerProviderStateMixin{
  var presenter = OfficialAccountPresenter();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    presenter.getOfficialAccountTab();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: presenter.tabStream,
          builder: (context,snapshot){
            if(snapshot.data == null){
              return ProgressView();
            }
            _controller = TabController(length: snapshot.data.length, vsync: this);
            return DefaultTabController(
                length: snapshot.data.length,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: TabBar(
                        controller: _controller,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(color: Colors.white,width: 3),
                            insets: EdgeInsets.fromLTRB(0, 0, 0, 0)
                        ),
                        tabs: snapshot.data.map<Tab>((TabLabel tab){
                          return Tab(text: tab.name,);
                        }).toList(),
                      ),
                    ),
                    Flexible(child: TabBarView(
                      controller: _controller,
                      children: snapshot.data.map<Widget>((TabLabel tab){
                        return OfficialAccountFragment(tab.id);
                      }).toList(),
                    ))
                  ],
                )
            );
          }
      ),
    );
  }

}

class OfficialAccountFragment extends StatefulWidget {

  int id;
  OfficialAccountFragment(this.id);

  @override
  _OfficialAccountFragmentState createState() => _OfficialAccountFragmentState();
}

class _OfficialAccountFragmentState extends BaseCollectState<OfficialAccountFragment> {

  final OfficialAccountListPresenter presenter = OfficialAccountListPresenter();

  RefreshController _controller = new RefreshController();

  @override
  void initState() {
    super.initState();
    presenter.id = widget.id;
    presenter.onRefresh();
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
                  .catchError((e)=>_controller.loadFailed());
            },
            itemCount:snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (context,index){
              return ArticleItemWidget(snapshot.data[index],);
            },
          );
        });
  }
}