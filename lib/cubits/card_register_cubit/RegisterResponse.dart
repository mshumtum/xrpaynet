import 'package:xr_paynet/core/api_bloc/SuccessResponse.dart';

class RegisterResponse extends SuccessResponse {
  Result? user_data;

  RegisterResponse.exception(String message) {
    super.msg = message;
  }

  RegisterResponse.fromJson(Map<String, dynamic> parsedJson) {
    status = parsedJson['status'];
    msg = parsedJson['message'];

    if (parsedJson['data'] != null) {
      user_data = Result(parsedJson["data"]["result"]);
    }
    // parsedJson['data'] = this.data!.toJson();
  }
}

class Result {
  bool? status;
  String? message;
  Result(json) {
    status = json['status'];
    message = json['message'];
  }
}
