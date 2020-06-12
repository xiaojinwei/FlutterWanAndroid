class Api {
  static const BASE_URL = "https://www.wanandroid.com/";

  //首页banner
  static const String BANNER_URL = "banner/json";

  //置顶文章
  static const String ARTICLE_TOP = "article/top/json";

  //首页文章
  static const String HOME_ARTICLE_LIST = "article/list/%i/json";

  //收藏站内文章
  static const String COLLECT = "lg/collect/%i/json";

  //取消收藏-文章列表
  static const String UN_COLLECT_ORIGIN_ID = "lg/uncollect_originId/%i/json";

  //获取项目分类
  static const String PROJECT_TAB = "project/tree/json";

  //获取项目列表数据
  static const String PROJECT_LIST = "project/list/%i/json?cid=%i";

  //获取公众号Tab
  static const String WECHAT_TAB = "wxarticle/chapters/json";

  //获取公众号文章 ,%i : 公众号 ID , %i : 公众号页码
  static const String WECHAT_LIST = "wxarticle/list/%i/%i/json";

  //获取体系数据
  static const String TREE = "tree/json";

  //获取导航数据
  static const String NAVIGATION = "navi/json";

  //知识体系下的文章 , %i : 页码 ,  %i : cid 分类的id，上述二级目录的id
  static const String TREE_LIST = "article/list/%i/json?cid=%i";

  //获取问答列表 , %i : 页码
  static const String WENDA_LIST = "wenda/list/%i/json";

  //获取广场数据 , %i : 页码
  static const String SQUARE_LIST = "user_article/list/%i/json";

  //登录
  static const String LOGIN = "user/login";

  //注册
  static const String REGISTER = "user/register";

  //获取收藏文章列表, %i : 页码
  static const String COLLECT_LIST = "lg/collect/list/%i/json";

  //获取用户积分数据
  static const String COIN_INFO = "lg/coin/userinfo/json";

  //获取积分列表, %i : 页码
  static const String RANK_LIST = "coin/rank/%i/json";

  //获取个人积分获取列表, %i : 页码
  static const String COIN_LG_LIST = "lg/coin/list/%i/json";

  //分享文章列表, %i : 页码
  static const String SHARE_ARTICLE_LIST = "user/lg/private_articles/%i/json";

  //分享文章
  static const String SHARE_ARTICLE = "lg/user_article/add/json";

  //分享人对应列表数据, %i : 用户id , %i : 页码
  static const String SHARE_ARTICLE_USER = "user/%i/share_articles/%i/json";

  //删除自己分享的文章, %i : 文章id
  static const String SHARE_ARTICLE_DELETE = "lg/user_article/delete/%i/json";

  //搜索热词
  static const String HOT_KEY = "hotkey/json";

  //搜索 %i : 页码
  static const String SEARCH_RESULT_LIST = "article/query/%i/json";
}