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
