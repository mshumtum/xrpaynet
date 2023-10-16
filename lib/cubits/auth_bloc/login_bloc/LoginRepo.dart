
import 'package:xr_paynet/components/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/components/api_bloc/api_url.dart';

import '../../../../core/network/api_service.dart';
import 'LoginResponse.dart';

 class LoginRepo{

  Future<LoginResponse> tryLoginReq(ApiRequest request) async {
    final response = await ApiService.hit(url: Uri.parse(LOGIN), body: request, header: {});
    return LoginResponse.fromJson(response);
  }

}