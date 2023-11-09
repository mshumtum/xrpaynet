class CountryListResponse {
  String? message;
  List<CountryListResult>? result;
  String? status;

  CountryListResponse({this.message, this.result, this.status});

  CountryListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <CountryListResult>[];
      json['result'].forEach((v) {
        result!.add(new CountryListResult.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class CountryListResult {
  int? uniqueId;
  int? mobileAreaCode;
  String? english;
  String? iso3166Alpha2;
  String? iso3166Alpha3;
  String? flag;

  CountryListResult(
      {this.uniqueId,
      this.mobileAreaCode,
      this.english,
      this.iso3166Alpha2,
      this.iso3166Alpha3,
      this.flag});

  CountryListResult.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    mobileAreaCode = json['mobileAreaCode'];
    english = json['english'];
    iso3166Alpha2 = json['iso3166Alpha2'];
    iso3166Alpha3 = json['iso3166Alpha3'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['mobileAreaCode'] = this.mobileAreaCode;
    data['english'] = this.english;
    data['iso3166Alpha2'] = this.iso3166Alpha2;
    data['iso3166Alpha3'] = this.iso3166Alpha3;
    data['flag'] = this.flag;
    return data;
  }
}
