import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/rank_presenter.dart';
import 'package:flutter_dynamic/presenter/square_presenter.dart';
import 'package:flutter_dynamic/redux/actions/auth_actions.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/ui/state/base_collect_state.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/rank_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/utils/account_util.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final presenter = RankPresenter();

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
        title: Text(I18nUtil.getS(context).ranking),
        centerTitle: true,
      ),
      body: StreamBuilder<List<RankData>>(
          stream: presenter.listStream,
          builder: (context,snapshot){
            return Column(
              children: <Widget>[
                Expanded(child: RefreshScaffold(
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
                    return RankItemWidget(snapshot.data[index],onTap: ()=>NavigatorUtil.gotoShare(context,userId: snapshot.data[index].userId),);
                  },
                )),
                _myRanking(context)
              ],
            );
          }),
    );
  }

  _myRanking(context){
    return StoreConnector<AppState,Store<AppState>>(
      converter: (Store<AppState> store) => store,
      builder: (context,store){
        var rank = store.state.authState?.rankData;
        if(rank == null){
          AccountUtil.isLoginStatus().then((value){
            if(value) {
              store.dispatch(coin());
            }
          });
          return Container(height: 0,width: 0,);
        }
        return RankItemWidget(rank,onTap: (){
          NavigatorUtil.gotoCoin(context);
        },);
      },
    );
  }

}
