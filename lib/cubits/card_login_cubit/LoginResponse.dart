import 'package:xr_paynet/core/api_bloc/SuccessResponse.dart';

class LoginResponse extends SuccessResponse {
  Result? user_data;

  LoginResponse.exception(String message) {
    super.msg = message;
  }

  LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    status = parsedJson['status'];
    msg = parsedJson['message'];

    if (parsedJson['data'] != null) {
      user_data = Result(parsedJson["data"]["result"]);
    }
  }
}

class Result {
  bool? success;
  String? token;
  Result(json) {
    success = json['success'];
    token = json['token'];
  }
}
