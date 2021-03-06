import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/project_list_presenter.dart';
import 'package:flutter_dynamic/presenter/project_presenter.dart';
import 'package:flutter_dynamic/ui/state/base_collect_state.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/ui/widgets/status_views.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_status.dart';

class ProjectPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage> with TickerProviderStateMixin{

  var presenter = ProjectPresenter();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    presenter.getProjectTab();
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
          stream: presenter.projectTabStream,
          builder: (context,snapshot){
            //if(snapshot.data == null){
            //  return ProgressView();
            //}
            _controller = TabController(length: snapshot.data?.length??0, vsync: this);
            return RefreshStatusView(
              loadStatus: Util.getLoadStatus(snapshot.hasError, snapshot.data),
              onRefresh: () => presenter.getProjectTab(),
              child: _body(context, snapshot),
              error: snapshot.error,
            );
          }
      ),
    );
  }

  _body(context,snapshot){
    if(snapshot.data == null) return Container();
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
                return ProjectFragment(tab.id);
              }).toList(),
            ))
          ],
        )
    );
  }

}

class ProjectFragment extends StatefulWidget {

  int cid;
  ProjectFragment(this.cid);

  @override
  _ProjectFragmentState createState() => _ProjectFragmentState();
}

class _ProjectFragmentState extends BaseCollectState<ProjectFragment> {

  final ProjectListPresenter presenter = ProjectListPresenter();

  RefreshController _controller = new RefreshController();

  @override
  void initState() {
    super.initState();
    presenter.cid = widget.cid;
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
                  .catchError((e)=>_controller.loadFailed());
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
