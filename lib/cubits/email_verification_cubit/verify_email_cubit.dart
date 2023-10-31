import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/constants/FormSubmissionStatus.dart';
import 'package:xr_paynet/core/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_register_cubit/RegisterResponse.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/VerifyEmailResponse.dart';

class VerifyEmailCubit extends Cubit<BaseState> {
  VerifyEmailCubit() : super(const BaseInit());

  clearState() {
    emit(const BaseInit());
  }

  verifyEmailByOTP({required String email, required String otp}) async {
    emit(BaseLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      VerifyEmailRequest request = VerifyEmailRequest(email: email, otp: otp);
      ApiService("");

      dynamic response = await ApiService.hit(
          url: Uri.parse(verifyEmailAPi), body: request, header: {});
      VerifyEmailResponse res = VerifyEmailResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(
            status: FormSubmissionStatus.success,
            token: res.user_data?.token)));
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

  completeVerification(VerifyEmailResponse response) {}

  emitError(error) {
    emit(BaseError(
      state.main.copyWith(
          status: FormSubmissionStatus.failure, errorMessage: error.toString()),
    ));
  }
}
