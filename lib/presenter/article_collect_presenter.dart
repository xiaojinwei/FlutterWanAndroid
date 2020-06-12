import 'package:flutter_dynamic/presenter/webview_presenter.dart';

import '../container.dart';

class ArticleCollectPresenter extends WebViewPresenter{
  Future deleteShare(int articleId,Function success,Function fail){
    return WanContainer().wanRepository.deleteShare(articleId)
        .then((value) => success(value))
        .catchError(fail);
  }
}