import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/home_presenter.dart';
import 'package:flutter_dynamic/ui/state/base_collect_state.dart';
import 'package:flutter_dynamic/ui/widgets/article_item.dart';
import 'package:flutter_dynamic/ui/widgets/refresh_scaffold.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BaseCollectState<HomePage>{

  final HomePresenter presenter = HomePresenter();
  RefreshController _controller = new RefreshController();

  @override
  void initState() {
    super.initState();
    presenter.onRefresh();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  Widget _buildBanner(BuildContext context,List<BannerData> list){
    if(list == null || list.isEmpty){
      return Container();
    }
    return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Swiper(
          autoplay: true,
          itemCount: list.length,
          pagination: new SwiperPagination(
            margin: EdgeInsets.all(0.0),
            builder: SwiperCustomPagination(
                builder: (context,config){
                  return Container(
                    color: Color(0x599E9E9E),
                    height: 40.0,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(list[config.activeIndex].title,
                                        style: TextStyle(fontSize: 12.0,color: Colors.white),),
                            )
                        ),
                        DotSwiperPaginationBuilder(
                          color: Colors.black12,
                          activeColor: Theme.of(context).primaryColor,
                          size: 6.0,
                          activeSize: 6.0
                        ).build(context, config)
                      ],
                    ),
                  );
                }
            )
          ),
          //control: new SwiperControl(),
          itemBuilder: (context,index){
            return Image.network(list[index].imagePath);
          },
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _scrollView(){
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: Text('xxx'),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                )
            ),
          )
        ];
      },
      body: _body(context),
    );
  }

  _body(context){
    return StreamBuilder<List<Article>>(
        stream: presenter.homeArticleStream,
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
            itemCount:snapshot.hasData ? snapshot.data.length + 1 : 0,
            itemBuilder: (context,index){
              return index == 0 ?
              presenter.bannerStream = presenter.bannerStream??StreamBuilder<List<BannerData>>(
                stream: presenter.homeBannerStream,
                builder: (context,snapshot){
                  if(snapshot.hasData && !snapshot.hasError && snapshot.connectionState == ConnectionState.active || presenter.bannerList.isNotEmpty){
                    if(snapshot.data != null) presenter.bannerList = snapshot.data;
                    return _buildBanner(context, snapshot.data??presenter.bannerList);
                  }else{
                    return Container();
                  }
                },
              )
                  :
              ArticleItemWidget(snapshot.data[index - 1],);
            },
          );
        });
  }

}