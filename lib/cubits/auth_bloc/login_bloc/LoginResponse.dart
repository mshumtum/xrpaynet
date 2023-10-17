import 'package:xr_paynet/components/api_bloc/SuccessResponse.dart';

class LoginResponse extends SuccessResponse{

  LoginResponse.exception(String message) {
    super.msg = message;
  }

  LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    status = parsedJson['statusCode'];
    msg = parsedJson['message'];
    if (parsedJson['data'] != null) {


    }
  }

}