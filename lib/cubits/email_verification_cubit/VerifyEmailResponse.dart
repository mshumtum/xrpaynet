import 'package:xr_paynet/core/api_bloc/SuccessResponse.dart';

class VerifyEmailResponse extends SuccessResponse {
  Result? user_data;

  VerifyEmailResponse.exception(String message) {
    super.msg = message;
  }

  VerifyEmailResponse.fromJson(Map<String, dynamic> parsedJson) {
    status = parsedJson['status'];
    msg = parsedJson['message'];

    if (parsedJson['result'] != null) {
      user_data = Result(parsedJson["result"]);
    }
    // parsedJson['data'] = this.data!.toJson();
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
