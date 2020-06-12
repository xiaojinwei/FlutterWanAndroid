import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dynamic/utils/cookie_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../application.dart';
import '../api.dart';
import '../result.dart';
import 'common_error.dart';

class HttpDio {

  static HttpDio _instance;

  static HttpDio get instance => _getInstance();

  factory HttpDio() => _getInstance();

  bool _wait = true;

  HttpDio._internal(){
    _dio = new Dio(_options);
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    if(_wait) _setCookie();
  }

  Future wait()async{
    return await _setCookie();
  }

  ///设置cookie
  Future<bool> _setCookie()async{
    /// 在拦截其中加入Cookie管理器
    var dir = await CookieUtil.getCookiePath();
    var cookieJar = PersistCookieJar(dir: dir);
    _dio.interceptors.add(CookieManager(cookieJar));
    _wait = false;
    return true;
  }

  static HttpDio _getInstance() {
    if(_instance == null){
      _instance = new HttpDio._internal();
    }
    return _instance;
  }

  Dio _dio;

  BaseOptions _options = getDefOptions();

  static BaseOptions getDefOptions() {
    return BaseOptions(
      baseUrl: Api.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
  }

  Dio get dio => _dio;

  void setOptions(BaseOptions options){
    _dio.options = options;
  }

  Future<Result<T>> get<T>(String path,{Map<String, dynamic> header})async{
    return request('GET', path,queryParameters: header);
  }

  Future<Result<T>> post<T>(String path,{data,Map<String, dynamic> header,Options options,})async{
    return request('POST', path,data:data,queryParameters: header,options: options);
  }

  Future<Result<T>> request<T>(
      String method,
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        CancelToken cancelToken,
        Options options,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
      }) async {
    return _request(path,data: data,queryParameters: queryParameters,cancelToken: cancelToken,
      options: _checkOptions(method, options),onSendProgress: onSendProgress,onReceiveProgress: onReceiveProgress);
  }

  Future<Result<T>> _request<T>(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        CancelToken cancelToken,
        Options options,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
      }) async {
    try {
      Response response = await _dio.request(path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,);
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        if (response.data != null) {
          Map<String, dynamic> decode = jsonDecode(response.data);
          var result = Result.fromJson(decode);
          if(!result.isSuccess()){
            processError(result);
          }
          return result;
        }
        var result = Result(code:Result.CODE_FAILURE,msg:'无响应体',data:null);
        processError(result);
        return result;
      }
    } on DioError catch (e) {
      print(e);
      var result = Result(code:Result.CODE_FAILURE,msg:CommonError.getErrorMsg(e.type, e.error),data:null);
      processError(result);
      return result;
    } catch (e) {
      print(e);
      var result = Result(code:Result.CODE_FAILURE,msg:e.toString(),data:null);
      processError(result);
      return result;
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    options.responseType = ResponseType.plain;
    return options;
  }

  processError(Result result){
    showError(result.msg);
    if(result.isTokenInvalid()){
      NavigatorUtil.gotoLogin(Application.instance.currentContext);
    }
  }

  showError(String msg){
    Fluttertoast.showToast(msg: msg??"");
  }

}

