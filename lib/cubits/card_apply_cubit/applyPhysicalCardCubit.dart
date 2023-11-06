import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/constants/FormSubmissionStatus.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/responses/CountryListResponse.dart';
import 'package:xr_paynet/cubits/card_register_cubit/RegisterResponse.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/VerifyEmailResponse.dart';

class ApplyPhysicalCardCubit extends Cubit<BaseState> {
  ApplyPhysicalCardCubit() : super(const BaseInit());

  clearState() {
    emit(const BaseInit());
  }

  getSupportedCountry() async {
    try {
      ApiService(Constants.userAccessToken);

      dynamic response = await ApiService.hit(
          url: Uri.parse(supportedCountryList), type: Constants.GET);
      CountryListResponse res = CountryListResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(countryList: res)));
      } else {
        emitError(res.message);
      }
    } catch (error) {
      emitError(error);
    }
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

  applyPhysicalCard({
    required String firstName,
    required String lastName,
    required String phoneNum,
    required int phoneCode,
    required String email,
    required int emailCode,
    required String countryCode,
    required String gender,
    required String country,
    required String province,
    required String city,
    required String streetAddress,
    required String postCode,
  }) async {
    emit(BaseLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      ApplyPhysicalCardRequest request = ApplyPhysicalCardRequest(
          email: email,
          cardType: "PHYSICAL",
          countryCode: countryCode,
          emailCode: emailCode,
          firstName: firstName,
          lastName: lastName,
          phoneCode: phoneCode,
          phoneNumber: phoneNum,
          cardId: 1223344,
          gender: gender,
          country: country,
          province: province,
          city: city,
          streetAddress: streetAddress,
          postCode: postCode,
          currency: "USD",
         currentTime:  DateTime.now().millisecondsSinceEpoch
      );
      print("request-----${request.toJson()}");
      ApiService(Constants.userAccessToken);

      dynamic response =
          await ApiService.hit(url: Uri.parse(cardApplyApi), body: request);
      VerifyEmailResponse res = VerifyEmailResponse.fromJson(response);
      if (res.status == "200") {
        emit(BaseSuccess(state.main.copyWith(
            status: FormSubmissionStatus.success, errorMessage: res.msg)));
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
