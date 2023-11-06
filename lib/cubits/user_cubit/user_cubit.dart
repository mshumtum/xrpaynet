import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/cubits/user_cubit/response/CardListingResponse.dart';
import 'package:xr_paynet/cubits/user_cubit/response/UserReponse.dart';
import 'package:xr_paynet/cubits/user_cubit/user_state.dart';

class UserDataCubit extends Cubit<UserState> {
  UserDataCubit() : super(const BaseInit());

  clearState() {
    emit(const BaseInit());
  }

  getUserDetailsFun() async {
    try {
      dynamic response = await ApiService.hit(
          url: Uri.parse(getUserDetails), type: Constants.GET);
      UserDataResponse res = UserDataResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(userData: res.data)));

      } else {
        emitError(res.message);
      }
    } catch (error) {
      emitError(error);
    }
  }

  getCardListing() async {
    try {
      ApiService(Constants.userAccessToken);
      emit(BaseLoading(
          state.main.copyWith(loading: true)));
      dynamic response = await ApiService.hit(
          url: Uri.parse(getAllCards), type: Constants.GET);
      CardListingResponse res = CardListingResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(cardListingResponse: res, loading: false)));
      } else {
        emit(BaseSuccess(state.main.copyWith( loading: false)));

        emitError(res.message);
      }
    } catch (error) {
      emitError(error);
    }
  }
  emitError(error) {

  }

}
