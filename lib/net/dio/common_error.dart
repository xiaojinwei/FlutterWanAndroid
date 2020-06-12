import 'package:dio/dio.dart';

class CommonError{
  static String getErrorMsg(DioErrorType type,dynamic error){
    switch(type){
      case DioErrorType.CONNECT_TIMEOUT:
        return 'connect timeout';
      case DioErrorType.SEND_TIMEOUT:
        return 'send timeout';
      case DioErrorType.RECEIVE_TIMEOUT:
        return 'receive timeout';
      case DioErrorType.RESPONSE:
        return 'incorrect response';
      case DioErrorType.CANCEL:
        return 'request cancel';
      case DioErrorType.DEFAULT:
        return error == null ? 'unknown error' : error.toString();
      default:
        return error.toString();
    }
  }
}