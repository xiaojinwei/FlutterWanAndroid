import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/system_tree_presenter.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/ui/widgets/tree_item.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SystemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SystemPageState();
  }
}

class _SystemPageState extends State<SystemPage> with TickerProviderStateMixin{

  TabController _controller ;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _controller.length,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Colors.white,width: 3),
                        insets: EdgeInsets.fromLTRB(0, 0, 0, 0)
                    ),
                    tabs: [Tab(text:I18nUtil.getS(context).tab_system),Tab(text:I18nUtil.getS(context).tab_navigation)],
                  ),
                ),
              ),
              Flexible(child: TabBarView(
                controller: _controller,
                children: [SystemTreeFragment(SystemTreeFragment.TYPE_TREE),SystemTreeFragment(SystemTreeFragment.TYPE_NAVI)],
              ))
            ],
          )
      ),
    );
  }

}

class SystemTreeFragment extends StatefulWidget {
  static const TYPE_TREE = 0;
  static const TYPE_NAVI = 1;

  int type;

  SystemTreeFragment(this.type);

  @override
  _SystemTreeFragmentState createState() => _SystemTreeFragmentState();
}

class _SystemTreeFragmentState extends State<SystemTreeFragment> {

  var presenter = SystemTreePresenter();

  RefreshController _controller = new RefreshController();

  @override
  void initState() {
    super.initState();
    widget.type == SystemTreeFragment.TYPE_NAVI
        ? presenter.requestNavigation()
        : presenter.requestTree();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BaseTree>>(
        stream: widget.type == SystemTreeFragment.TYPE_NAVI ? presenter.naviStream : presenter.treeStream,
        builder: (context,snapshot){
          return RefreshScaffold(
            loadStatus: Util.getLoadStatus(snapshot.hasError, snapshot.data),
            enablePullUp: false,
            controller: _controller,
            onRefresh: ({isReload}){
              return widget.type == SystemTreeFragment.TYPE_NAVI ? presenter.requestNavigation() : presenter.requestTree();
            },
            itemCount:snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (context,index){
              return TreeItem(snapshot.data[index],);
            },
          );
        });
  }
}
