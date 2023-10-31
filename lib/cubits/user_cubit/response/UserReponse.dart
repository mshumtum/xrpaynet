class UserDataResponse {
  String? status;
  String? message;
  Data? data;

  UserDataResponse({this.status, this.message, this.data});

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  UserInfo? userInfo;
  List<CardInfo>? cardInfo;

  Data({this.userInfo, this.cardInfo});

  Data.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    if (json['cardInfo'] != null) {
      cardInfo = <CardInfo>[];
      json['cardInfo'].forEach((v) {
        cardInfo!.add(new CardInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    if (this.cardInfo != null) {
      data['cardInfo'] = this.cardInfo!.map((v) => v.toJson()).toList();
    }
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
  int? id;
  int? cardId;
  String? cardType;
  String? status;
  int? userId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String? email;
  String? gender;
  String? country;
  String? currency;
  String? province;
  String? city;
  String? streetAddress;
  String? postCode;

  CardInfo(
      {this.id,
      this.cardId,
      this.cardType,
      this.status,
      this.userId,
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
      this.postCode});

  CardInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardId = json['card_id'];
    cardType = json['card_type'];
    status = json['status'];
    userId = json['user_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_id'] = this.cardId;
    data['card_type'] = this.cardType;
    data['status'] = this.status;
    data['user_id'] = this.userId;
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
    return data;
  }
}
