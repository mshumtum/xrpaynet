import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/cubits/user_cubit/response/UserReponse.dart';
import 'package:xr_paynet/cubits/user_cubit/user_state.dart';

class UserDataCubit extends Cubit<UserState> {
  UserDataCubit() : super(const BaseInit());

  clearState() {
    emit(const BaseInit());
  }

  getUserDetailsFun() async {
    try {
      ApiService(Constants.userAccessToken);

      dynamic response = await ApiService.hit(
          url: Uri.parse(getUserDetails), type: Constants.GET);
      UserDataResponse res = UserDataResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(userInfo: res.data?.userInfo)));
      } else {
        // emitError(res.message);
      }
    } catch (error) {
      // emitError(error);
    }
  }
}
