import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/coin_presenter.dart';
import 'package:flutter_dynamic/ui/widgets/coin_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  final presenter = CoinPresenter();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nUtil.getS(context).points_details),
        centerTitle: true,
      ),
      body: StreamBuilder<List<CoinData>>(
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
                return CoinItemWidget(snapshot.data[index],);
              },
            );
          }),
    );
  }

}
