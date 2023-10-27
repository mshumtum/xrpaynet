import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/core/network/message.dart';
import '../../constants/FormSubmissionStatus.dart';
import '../../core/Locator.dart';
import 'LoginResponse.dart';
import 'package:http/http.dart' as http;

part 'login_state.dart';

class CardLoginCubit extends Cubit<LoginState> {
  CardLoginCubit() : super(const LoginInit());

  clearState() {
    emit(const LoginInit());
  }

  loginWithEmailPasswordPressed(
      {required String email, required String password}) async {
    emit(LoginWithEmailLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      LoginRequest request = LoginRequest(email: email, password: password);
      ApiService("");
      dynamic response = await ApiService.hit(
          url: Uri.parse(LOGIN), body: request, header: {});
      LoginResponse res = LoginResponse.fromJson(response);
      if (res.status == "200") {
        continueLogin(res);
      } else {
        if (res.msg.contains("not verified")) {
          emit(UserLoggedIn(state.main.copyWith(
              status: FormSubmissionStatus.pending, message: res.msg)));
        } else {
          emitError(res.msg);
        }
      }
    } catch (error) {
      emitError(error.toString());
    }
  }

  emitError(error) {
    int pendingAttempts = 5;
    if (error != SOCKET_EXCEPTION) {
      pendingAttempts = state.main.attempt - 1;
    }
    emit(LoginWithEmailError(state.main.copyWith(
        status: FormSubmissionStatus.failure,
        message: '',
        errorMessage: error,
        attempt: pendingAttempts)));
    if (pendingAttempts <= 0) {
      emit(LoginWithEmailError(state.main.copyWith(
        status: FormSubmissionStatus.attemptFail,
      )));
    }
  }

  continueLogin(LoginResponse user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessToken, user.user_data?.token ?? '');
    Constants.userAccessToken = user.user_data?.token ?? '';
    emit(UserLoggedIn(state.main.copyWith(
        status: FormSubmissionStatus.success,
        message: 'User logged in',
        errorMessage: '')));
  }

  startTimer() async {
    DateTime now = DateTime.now();
    Duration fiveMinutes = Duration(seconds: 60);
    int timestamp = now.millisecondsSinceEpoch;
    int newTimestamp = timestamp + fiveMinutes.inMilliseconds;
    print("timestamp=====$timestamp");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constants.loginAttemptFailTime, newTimestamp);

    emit(LoginAttemptState(state.main.copyWith(
        isTimerRunning: true,
        timestampOnStart: newTimestamp,
        status: FormSubmissionStatus.initial)));
  }

  updateTimer({required int timer}) {
    emit(LoginAttemptState(state.main.copyWith(
        timestampOnStart: timer,
        attempt: 0,
        isTimerRunning: true,
        status: FormSubmissionStatus.checkAttemptFailTime)));
  }

  stopTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constants.loginAttemptFailTime, 0);
    emit(LoginAttemptState(state.main.copyWith(
      isTimerRunning: false,
      counter: 60,
      attempt: 5,
    )));
  }
}
