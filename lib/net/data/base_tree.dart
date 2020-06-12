
///合并体系KnowledgeData和导航NavigationData两个功能bean的基类
///抽取KnowledgeData，NavigationData中需要使用的字段放入基类
class BaseTree<T> {
  String name;
  int id;
  int cid;
  String link;
  String title;
  bool collect;

  List<T> children;
  List<T> articles;

  ///需要显示的标签
  String showLabel(){
    return name??title;
  }

  int getChildrenLength(){
    return children?.length??articles?.length??0;
  }

  List<T> getChildren(){
    return children??articles;
  }

  ///是否是导航，是则需要跳转到WebView
  bool isNaviWeb(){
    return link != null;
  }

}