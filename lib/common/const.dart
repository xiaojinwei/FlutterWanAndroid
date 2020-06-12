class Const{
  static const supportFontFamily = [
    'Local',
    'Allura',
    'NotoSansTC',
    'NotoSerifTC',
    'Roboto',
  ];

  static const fontChina = "中国 China 1949";
}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}

class ThemeModeStatus {
  static const int system = 0;//跟随系统
  static const int dark = 1;//深色，暗黑模式
  static const int light = 2;//正常
}