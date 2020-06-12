import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic/presenter/base_collect_presenter.dart';
import 'package:flutter_dynamic/event/collect_event.dart';
import 'package:flutter_dynamic/ui/state/token_state.dart';
import 'package:flutter_dynamic/utils/bus_util.dart';

abstract class BaseCollectState<T extends StatefulWidget> extends TokenState<T> {

  BaseCollectPresenter presenter;
  StreamSubscription<CollectEvent> _subscriptionCollect;

  @override
  void initState() {
    initEventBus();
    super.initState();
  }

  @override
  void dispose() {
    presenter?.dispose();
    _subscriptionCollect?.cancel();
    super.dispose();
  }

  void initEventBus() {
    _subscriptionCollect = BusUtil.eventBus.on<CollectEvent>().listen((event) {
      eventRefresh(event);
    });
  }

  void eventRefresh(CollectEvent event){
    if(event.type == CollectEvent.TYPE_REFRESH){
      presenter?.onRefresh();
    }else if(event.type == CollectEvent.TYPE_PART){
      partRefresh(event);
    }
  }

  ///CollectEvent.TYPE_PART
  void partRefresh(CollectEvent event){
    setState(() {
      var where = presenter?.articleList?.firstWhere((element) => element.id == event.id);
      if(where != null)
        where?.collect = event.collect;
    });
  }

  ///收藏页/分享页(删除按钮的)是移除条目，其他文章列表不移除，所以需要在指定页面手动调用移除
  ///CollectEvent.TYPE_PART_REMOVE
  void partRemoveRefresh(CollectEvent event){
    setState(() {
      presenter?.articleList?.removeWhere((element) => element.id == event.id);
    });
  }

}