class CoinData {
  int id;
  int userId;
  int type;
  int coinCount;
  String userName;
  String reason;
  String desc;
  int date;

  CoinData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    coinCount = json['coinCount'];
    userName = json['userName'];
    reason = json['reason'];
    desc = json['desc'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['coinCount'] = this.coinCount;
    data['userName'] = this.userName;
    data['reason'] = this.reason;
    data['desc'] = this.desc;
    data['date'] = this.date;
    return data;
  }
}
