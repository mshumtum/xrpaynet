import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/constants/FormSubmissionStatus.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/responses/ApplyVirtualCardResponse.dart';
import 'package:xr_paynet/cubits/card_register_cubit/RegisterResponse.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/VerifyEmailResponse.dart';

class ApplyVirtualCardCubit extends Cubit<BaseState> {
  ApplyVirtualCardCubit() : super(const BaseInit());
  clearState() {
    emit(const BaseInit());
  }

  sendOTPForVerification({required String medium, required String type}) async {
    emit(BaseLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      SendCodeOnCardApply request =
          SendCodeOnCardApply(type: type, medium: medium);
      ApiService(Constants.userAccessToken);

      dynamic response = await ApiService.hit(
        url: Uri.parse(resendOtpAPi),
        body: request,
      );
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

  applyVirtualCard({
    required String firstName,
    required String lastName,
    required String phoneNum,
    required int phoneCode,
    required String email,
    required int emailCode,
    required String countryCode,
    required String countryName,
    required int cardId,
  }) async {
    emit(BaseLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      ApplyVirtualCardRequest request = ApplyVirtualCardRequest(
          email: email,
          cardType: "VIRTUAL",
          countryCode: countryCode,
          emailCode: emailCode,
          firstName: firstName,
          lastName: lastName,
          phoneCode: phoneCode,
          phoneNumber: phoneNum,
          country: countryName,
          cardId: cardId,
          currentTime: DateTime.now().millisecondsSinceEpoch.toString());
      print("request-----${request.toJson()}");
      ApiService(Constants.userAccessToken);

      dynamic response =
          await ApiService.hit(url: Uri.parse(cardApplyApi), body: request);
      ApplyVirtualCardResponse res =
          ApplyVirtualCardResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(
            status: FormSubmissionStatus.success, errorMessage: res.message)));
      } else {
        emitError(res.message);
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
