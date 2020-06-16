import 'package:flutter/material.dart';
import 'package:flutter_dynamic/common/const.dart';
import 'package:flutter_dynamic/ui/widgets/status_views.dart';

typedef OnRefreshStatusCallback = Future<void> Function();

class RefreshStatusView extends StatefulWidget {
  const RefreshStatusView(
      {Key key,
        this.loadStatus,
        this.onRefresh,
        this.child,
        this.error})
      : super(key: key);

  final int loadStatus;
  final OnRefreshStatusCallback onRefresh;
  final Widget child;
  final String error;
  @override
  _RefreshStatusState createState() => _RefreshStatusState();
}

class _RefreshStatusState extends State<RefreshStatusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.loadStatus == LoadStatus.success ? widget.child :
      new StatusViews(
        widget.loadStatus,
        error: widget.error,
        onTap: () {
          widget.onRefresh();
        },
      ),
    );
  }
}
