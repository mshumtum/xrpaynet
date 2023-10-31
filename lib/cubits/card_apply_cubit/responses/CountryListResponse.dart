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
  String? name;
  String? dialCode;
  String? emoji;
  String? code;

  CountryListResult({this.name, this.dialCode, this.emoji, this.code});

  CountryListResult.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dialCode = json['dial_code'];
    emoji = json['emoji'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dial_code'] = this.dialCode;
    data['emoji'] = this.emoji;
    data['code'] = this.code;
    return data;
  }
}
