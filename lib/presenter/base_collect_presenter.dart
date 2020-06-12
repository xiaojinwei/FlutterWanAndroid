import 'package:flutter_dynamic/net/data/index.dart';
import 'base_presenter.dart';

///用于Article列表收藏使用
abstract class BaseCollectPresenter extends BasePresenter {
  ///整理刷新,调用刷新接口
  onRefresh();
  ///局部刷新
  ///找到对应的Article,将其collect致反，然后setState
  List<Article> articleList;
}