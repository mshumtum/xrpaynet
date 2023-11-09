class UserDataResponse {
  String? status;
  String? message;
  UserData? data;

  UserDataResponse({this.status, this.message, this.data});

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  UserInfo? userInfo;
  List<CardInfo>? cardInfo;
  Null? cardCredentials;

  UserData({this.userInfo, this.cardInfo, this.cardCredentials});

  UserData.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    if (json['cardInfo'] != null) {
      cardInfo = <CardInfo>[];
      json['cardInfo'].forEach((v) {
        cardInfo!.add(new CardInfo.fromJson(v));
      });
    }
    cardCredentials = json['cardCredentials'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    if (this.cardInfo != null) {
      data['cardInfo'] = this.cardInfo!.map((v) => v.toJson()).toList();
    }
    data['cardCredentials'] = this.cardCredentials;
    return data;
  }
}

class UserInfo {
  String? email;
  int? totalCards;

  UserInfo({this.email, this.totalCards});

  UserInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    totalCards = json['totalCards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['totalCards'] = this.totalCards;
    return data;
  }
}

class CardInfo {
  int? cardId;
  String? cardType;
  String? status;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String? email;
  Null? gender;
  String? country;
  Null? currency;
  Null? province;
  Null? city;
  Null? streetAddress;
  Null? postCode;
  String? mcTradeNo;
  bool? isBind;
  Credentials? credentials;

  CardInfo(
      {this.cardId,
      this.cardType,
      this.status,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.countryCode,
      this.email,
      this.gender,
      this.country,
      this.currency,
      this.province,
      this.city,
      this.streetAddress,
      this.postCode,
      this.mcTradeNo,
      this.isBind,
      this.credentials});

  CardInfo.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    cardType = json['card_type'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    email = json['email'];
    gender = json['gender'];
    country = json['country'];
    currency = json['currency'];
    province = json['province'];
    city = json['city'];
    streetAddress = json['street_address'];
    postCode = json['post_code'];
    mcTradeNo = json['mc_trade_no'];
    isBind = json['isBind'];
    credentials = json['credentials'] != null
        ? new Credentials.fromJson(json['credentials'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['card_type'] = this.cardType;
    data['status'] = this.status;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['province'] = this.province;
    data['city'] = this.city;
    data['street_address'] = this.streetAddress;
    data['post_code'] = this.postCode;
    data['mc_trade_no'] = this.mcTradeNo;
    data['isBind'] = this.isBind;
    if (this.credentials != null) {
      data['credentials'] = this.credentials!.toJson();
    }
    return data;
  }
}

class Credentials {
  String? cardTypeId;
  String? cardId;
  String? cardNumber;
  int? cardStatus;
  String? failReason;
  int? createTimestamp;

  Credentials(
      {this.cardTypeId,
      this.cardId,
      this.cardNumber,
      this.cardStatus,
      this.failReason,
      this.createTimestamp});

  Credentials.fromJson(Map<String, dynamic> json) {
    cardTypeId = json['card_type_id'];
    cardId = json['card_id'];
    cardNumber = json['card_number'];
    cardStatus = json['card_status'];
    failReason = json['fail_reason'];
    createTimestamp = json['create_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_type_id'] = this.cardTypeId;
    data['card_id'] = this.cardId;
    data['card_number'] = this.cardNumber;
    data['card_status'] = this.cardStatus;
    data['fail_reason'] = this.failReason;
    data['create_timestamp'] = this.createTimestamp;
    return data;
  }
}
