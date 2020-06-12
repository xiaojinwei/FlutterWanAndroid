class CollectEvent {
  static const TYPE_REFRESH = 0;//整体调用网络刷新
  static const TYPE_PART = 1;//局部刷新，不调用网络
  static const TYPE_PART_REMOVE = 2;//局部刷新，不调用网络，强制移除该条目
  int type;

  int id;//条目ID
  bool collect;//是否是搜藏
  dynamic tag;

  CollectEvent({this.type,this.id,this.collect,this.tag});

  static CollectEvent createRefreshEvent(){
    return CollectEvent(type: TYPE_REFRESH);
  }

  static CollectEvent createPartEvent(int id,bool collect,{dynamic tag}){
    return CollectEvent(type: TYPE_PART,id: id,collect: collect,tag: tag);
  }

  static CollectEvent createPartRemoveEvent(int id,bool collect,{dynamic tag}){
    return CollectEvent(type: TYPE_PART_REMOVE,id: id,collect: collect,tag: tag);
  }

}