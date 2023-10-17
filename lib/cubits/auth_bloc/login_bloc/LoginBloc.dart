import 'package:flutter/cupertino.dart';
import 'package:xr_paynet/components/api_bloc/api_req/ApiRequest.dart';

import '../../../components/utilities/utility.dart';
import '../../../components/widgets/NoInternetWidget.dart';
import 'LoginRepo.dart';
import 'LoginResponse.dart';

class LoginBloc {
  final LoginRepo _repo = LoginRepo();
/*~~~~~~Login Req~~~~~~~*/
  Future<LoginResponse?> tryLoginAccount(ApiRequest request) async {
    if (await isConnectedToInternet()) {
      LoginResponse response = await _repo.tryLoginReq(request);
      return response;
    } else {
      const NoInternetWidget();
    }
    return null;
  }
}