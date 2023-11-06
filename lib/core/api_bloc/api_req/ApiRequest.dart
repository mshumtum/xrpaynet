class LoginRequest {
  dynamic? email;
  dynamic? password;

  LoginRequest({this.email, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class VerifyEmailRequest {
  dynamic? email;
  dynamic? otp;

  VerifyEmailRequest({this.email, this.otp});

  VerifyEmailRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }
}

class ResendEmailVerifyOTP {
  dynamic? email;
  dynamic? otp;

  ResendEmailVerifyOTP({
    this.email,
  });

  ResendEmailVerifyOTP.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class CreateForgotPasswordRequest {
  dynamic? password;
  dynamic? token;

  CreateForgotPasswordRequest({
    this.password,
    this.token,
  });

  CreateForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['token'] = token;
    return data;
  }
}

class SendCodeOnCardApply {
  dynamic? medium;
  dynamic? type;

  SendCodeOnCardApply({
    this.medium,
    this.type,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[type] = medium;
    data["digit"] = 4;
    return data;
  }
}

class ApplyVirtualCardRequest {
  dynamic? cardType;
  dynamic? firstName;
  dynamic? lastName;
  dynamic? phoneNumber;
  dynamic? phoneCode;
  dynamic? email;
  dynamic? emailCode;
  dynamic? countryCode;
  dynamic? country;
  dynamic? cardId;
  dynamic? currentTime;

  ApplyVirtualCardRequest({
    this.cardType,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.phoneCode,
    this.email,
    this.emailCode,
    this.countryCode,
    this.country,
    this.cardId,
    this.currentTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_type'] = cardType;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['phone_code'] = phoneCode;
    data['email'] = email;
    data['email_code'] = emailCode;
    data['country_code'] = countryCode;
    data['country'] = country;
    data['card_id'] = cardId;
    // data['timestamp'] = currentTime;
    return data;
  }
}

class ApplyPhysicalCardRequest {
  dynamic? cardType;
  dynamic? firstName;
  dynamic? lastName;
  dynamic? phoneNumber;
  dynamic? phoneCode;
  dynamic? email;
  dynamic? emailCode;
  dynamic? countryCode;
  dynamic? cardId;
  dynamic? gender;
  dynamic? country;
  dynamic? currency;
  dynamic? province;
  dynamic? city;
  dynamic? streetAddress;
  dynamic? postCode;
  dynamic? currentTime;


  ApplyPhysicalCardRequest({
    this.cardType,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.phoneCode,
    this.email,
    this.emailCode,
    this.countryCode,
    this.cardId,
    this.gender,
    this.country,
    this.currency,
    this.province,
    this.city,
    this.streetAddress,
    this.postCode,
    this.currentTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_type'] = cardType;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['phone_code'] = phoneCode;
    data['email'] = email;
    data['email_code'] = emailCode;
    data['country_code'] = countryCode;
    data['card_id'] = cardId;
    data['gender'] = gender;
    data['country'] = country;
    data['currency'] = currency;
    data['province'] = province;
    data['city'] = city;
    data['street_address'] = streetAddress;
    data['post_code'] = postCode;
    data['currentTime'] = currentTime;
    return data;
  }
}
