import '../container.dart';
import 'base_presenter.dart';

class WebViewPresenter extends BasePresenter {

  Future collect(int id,Function success,Function fail){
    return WanContainer().wanRepository.collect(id)
        .then((value) => success(value))
        .catchError(fail);
  }

  Future unCollect(int id,Function success,Function fail){
    return WanContainer().wanRepository.unCollectOriginId(id)
        .then((value) => success(value))
        .catchError(fail);
  }

  Future addShare(String title,String link,Function success,Function fail){
    return WanContainer().wanRepository.addShare(title,link)
        .then((value) => success(value))
        .catchError(fail);
  }

  @override
  void dispose() {

  }

}