

import 'package:xr_paynet/components/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/components/api_bloc/auth_bloc/login_bloc/LoginRepo.dart';
import 'package:xr_paynet/components/api_bloc/auth_bloc/login_bloc/LoginResponse.dart';

class BaseRepo {

  Future<LoginResponse> callLoginApi (LoginRequest request){
       var result= LoginRepo().tryLoginReq(request);
       return result;
  }


}