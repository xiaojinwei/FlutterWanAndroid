import 'package:flutter/material.dart';
import 'package:flutter_dynamic/ui/widgets/status_views.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

typedef void OnLoadMore();
typedef OnRefreshCallback = Future<void> Function({bool isReload});

class RefreshScaffold extends StatefulWidget {
  const RefreshScaffold(
      {Key key,
      this.labelId,
      this.loadStatus,
      @required this.controller,
      this.enablePullUp: true,
      this.onRefresh,
      this.onLoadMore,
      this.child,
      this.itemCount,
      this.itemBuilder})
      : super(key: key);

  final String labelId;
  final int loadStatus;
  final pull.RefreshController controller;
  final bool enablePullUp;
  final OnRefreshCallback onRefresh;
  final OnLoadMore onLoadMore;
  final Widget child;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() {
    return new RefreshScaffoldState();
  }
}

///   with AutomaticKeepAliveClientMixin
class RefreshScaffoldState extends State<RefreshScaffold>
    with AutomaticKeepAliveClientMixin {
  bool isShowFloatBtn = false;

  @override
  void initState() {
    super.initState();
//    LogUtil.e("RefreshScaffold initState......" + widget.labelId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.scrollController.addListener(() {
        int offset = widget.controller.scrollController.offset.toInt();
        if (offset < 480 && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else if (offset > 480 && !isShowFloatBtn) {
          isShowFloatBtn = true;
          setState(() {});
        }
      });
    });
  }

  Widget buildFloatingActionButton() {
    if (widget.controller.scrollController == null ||
        widget.controller.scrollController.offset < 480) {
      return null;
    }

    return new FloatingActionButton(
        heroTag: widget.labelId,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          //_controller.scrollTo(0.0);
          widget.controller.scrollController.animateTo(0.0,
              duration: new Duration(milliseconds: 300), curve: Curves.linear);
        });
  }

  @override
  Widget build(BuildContext context) {
//    LogUtil.e("RefreshScaffold build...... " + widget.labelId);
    super.build(context);
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new RefreshIndicator(
                child: new pull.SmartRefresher(
                    controller: widget.controller,
                    enablePullDown: false,
                    enablePullUp: widget.enablePullUp,
                    //onRefresh: widget.onLoadMore,
                    onLoading: widget.onLoadMore,
                    child: widget.child ??
                        new ListView.builder(
                          itemCount: widget.itemCount,
                          itemBuilder: widget.itemBuilder,
                        )),
                onRefresh: widget.onRefresh),
            new StatusViews(
              widget.loadStatus,
              onTap: () {
                widget.onRefresh(isReload: true);
              },
            ),
          ],
        ),
        floatingActionButton: buildFloatingActionButton());
  }

  @override
  bool get wantKeepAlive => true;
}
