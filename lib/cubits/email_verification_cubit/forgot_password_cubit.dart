import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/constants/FormSubmissionStatus.dart';
import 'package:xr_paynet/core/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_register_cubit/RegisterResponse.dart';

class ForgotPasswordCubit extends Cubit<BaseState> {
  ForgotPasswordCubit() : super(const BaseInit());

  clearState() {
    emit(const BaseInit());
  }

  resetUserPassword({required String email}) async {
    emit(BaseLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      ResendEmailVerifyOTP request = ResendEmailVerifyOTP(email: email);
      ApiService("");

      dynamic response = await ApiService.hit(
          url: Uri.parse(resendOtpAPi), body: request, header: {});
      RegisterResponse res = RegisterResponse.fromJson(response);
      if (res.status == "200") {
        // continueRegistration(res);
        emit(BaseSuccess(state.main.copyWith(
            status: FormSubmissionStatus.pending, errorMessage: res.msg)));
      } else {
        emitError(res.msg);
      }
    } catch (error) {
      emitError(error);
    }
  }

  sendEmailVerifyOTP({required String email}) async {
    emit(BaseLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      ResendEmailVerifyOTP request = ResendEmailVerifyOTP(email: email);
      ApiService("");

      dynamic response = await ApiService.hit(
          url: Uri.parse(resendOtpAPi), body: request, header: {});
      RegisterResponse res = RegisterResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(
            status: FormSubmissionStatus.pending, errorMessage: res.msg)));
      } else {
        emitError(res.msg);
      }
    } catch (error) {
      emitError(error);
    }
  }

  emitError(error) {
    emit(BaseError(
      state.main.copyWith(
          status: FormSubmissionStatus.failure, errorMessage: error.toString()),
    ));
  }
}
