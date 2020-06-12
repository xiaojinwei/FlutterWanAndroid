import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_dynamic/net/api.dart';
import 'package:flutter_dynamic/net/dio/http_dio.dart';
import 'package:path_provider/path_provider.dart';

class CookieUtil {
  /// 获取cookie地址
  static Future<String> getCookiePath() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    return "${tempPath}/cookies/";
  }

  ///清除所有cookie
  static Future<Null> deleteAllCookies() async {
    await getCookiePath().then((path) {
      PersistCookieJar cookieJar = PersistCookieJar(dir: path);
      cookieJar.deleteAll();
    });
  }

  ///等待完成初始化
  ///1.等待加载持久化的cookie，并将其设置到dio拦截器，否则在首页调用接口时cookie还没有设置到dio
  static Future wait()async{
    return await HttpDio.instance.wait();
  }

  ///持久化的cookie是否过期
  static Future<bool> isExpired()async{
    var path = await getCookiePath();//获取路径
    PersistCookieJar cookieJar = PersistCookieJar(dir: path);
    var cookies = cookieJar.loadForRequest(Uri.parse(Api.BASE_URL));//加载对应URL的cookie
    if(cookies != null && cookies.length > 0){
      return new SerializableCookie(cookies[0]).isExpired();//判断cookie是否过期
    }
    return true;
  }

}