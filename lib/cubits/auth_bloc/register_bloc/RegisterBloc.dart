import 'package:xr_paynet/cubits/auth_bloc/register_bloc/RegisterRepo.dart';

import '../../../components/api_bloc/api_req/ApiRequest.dart';
import '../../../components/utilities/utility.dart';
import '../../../components/widgets/NoInternetWidget.dart';
import '../login_bloc/LoginResponse.dart';

class RegisterBloc{
  final RegisterRepo _repo = RegisterRepo();
/*~~~~~~SignUp Req~~~~~~~*/
  Future<LoginResponse?> userRegister(ApiRequest request) async {
    if (await isConnectedToInternet()) {
      LoginResponse response = await _repo.userRegisterReq(request);
      return response;
    } else {
      const NoInternetWidget();
    }
    return null;
  }
}