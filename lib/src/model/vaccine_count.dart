class VaccineCount {
  int? currentCount;
  List<Data>? data;
  int? matchCount;
  int? page;
  int? perPage;
  int? totalCount;

  VaccineCount(
      { this.currentCount,
        this.data,
        this.matchCount,
        this.page,
        this.perPage,
        this.totalCount});

  VaccineCount.fromJson(Map<String, dynamic> json) {
    currentCount = json['currentCount'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
    matchCount = json['matchCount'];
    page = json['page'];
    perPage = json['perPage'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentCount'] = this.currentCount;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['matchCount'] = this.matchCount;
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Data {
  int? accumulatedFirstCnt;
  int? accumulatedSecondCnt;
  String? baseDate;
  int? firstCnt;
  int? secondCnt;
  String? sido;
  int? totalFirstCnt;
  int? totalSecondCnt;

  Data(
      {this.accumulatedFirstCnt,
        this.accumulatedSecondCnt,
        this.baseDate,
        this.firstCnt,
        this.secondCnt,
        this.sido,
        this.totalFirstCnt,
        this.totalSecondCnt});

  Data.fromJson(Map<String, dynamic> json) {
    accumulatedFirstCnt = json['accumulatedFirstCnt'];
    accumulatedSecondCnt = json['accumulatedSecondCnt'];
    baseDate = json['baseDate'];
    firstCnt = json['firstCnt'];
    secondCnt = json['secondCnt'];
    sido = json['sido'];
    totalFirstCnt = json['totalFirstCnt'];
    totalSecondCnt = json['totalSecondCnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accumulatedFirstCnt'] = this.accumulatedFirstCnt;
    data['accumulatedSecondCnt'] = this.accumulatedSecondCnt;
    data['baseDate'] = this.baseDate;
    data['firstCnt'] = this.firstCnt;
    data['secondCnt'] = this.secondCnt;
    data['sido'] = this.sido;
    data['totalFirstCnt'] = this.totalFirstCnt;
    data['totalSecondCnt'] = this.totalSecondCnt;
    return data;
  }
}
