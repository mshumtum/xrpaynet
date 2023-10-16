import 'package:flutter/cupertino.dart';
import 'package:xr_paynet/components/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/components/api_bloc/auth_bloc/login_bloc/LoginRepo.dart';
import 'package:xr_paynet/components/api_bloc/auth_bloc/login_bloc/LoginResponse.dart';

import '../../../utilities/utility.dart';
import '../../../widgets/NoInternetWidget.dart';

class LoginBloc {
  final LoginRepo _repo = LoginRepo();
/*~~~~~~Login Req~~~~~~~*/
  Future<LoginResponse?> tryLoginAccount(LoginRequest request,BuildContext context, String accessToken) async {
    if (await isConnectedToInternet()) {
      // setUserHeader(accessToken);
      LoginResponse response = await _repo.tryLoginReq(request);
      return response;
    } else {
      hideLoader(context);
      const NoInternetWidget();
    }
    return null;
  }
}