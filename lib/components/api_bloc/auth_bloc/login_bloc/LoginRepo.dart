
import 'package:xr_paynet/components/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/components/api_bloc/api_url.dart';
import 'package:xr_paynet/components/api_bloc/auth_bloc/login_bloc/LoginResponse.dart';

import '../../../../core/network/api_service.dart';

 class LoginRepo{

  Future<LoginResponse> tryLoginReq(LoginRequest request) async {
    final response = await ApiService.hit(url: Uri.parse(LOGIN), body: request.toMap(), header: {});
    return LoginResponse.fromJson(response);
  }

  // Future<Either<Failure, List<LoginResponse>>> loginData(
  //     LoginRequest params,
  //     );



}