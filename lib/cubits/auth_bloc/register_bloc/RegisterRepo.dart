import '../../../components/api_bloc/api_req/ApiRequest.dart';
import '../../../components/api_bloc/api_url.dart';
import '../../../core/network/api_service.dart';
import '../login_bloc/LoginResponse.dart';

class RegisterRepo {
  Future<LoginResponse> userRegisterReq(ApiRequest request) async {
    final response = await ApiService.hit(url: Uri.parse(USER_REGISTER), body: request, header: {});
    return LoginResponse.fromJson(response);
  }
}