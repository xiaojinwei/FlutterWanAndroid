class Result<T>{
  static const CODE_SUCCESS = 0;
  static const CODE_TOKEN_INVALID = -1001;
  static const CODE_FAILURE = -1;

  ///static const STATUS_SUCCESS = 'SUCCUSS';
  ///static const STATUS_FAILURE = 'FAILURE';

  static const FIELD_CODE = 'errorCode';
  static const FIELD_MESSAGE = 'errorMsg';
  static const FIELD_DATA = 'data';

  int code;
  String msg;
  T data;

  Result({this.code,this.msg,this.data});

  Result.fromJson(Map<String, dynamic> json)
      : code = json[FIELD_CODE],
        msg = json[FIELD_MESSAGE],
        data = json[FIELD_DATA];

  bool isSuccess() => code == CODE_SUCCESS;

  bool isTokenInvalid() => code == CODE_TOKEN_INVALID;

}