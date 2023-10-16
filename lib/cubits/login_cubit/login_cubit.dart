import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:xr_paynet/components/api_bloc/api_req/ApiRequest.dart';


import '../../constants/constants.dart';
import '../auth_bloc/login_bloc/LoginBloc.dart';
import '../auth_bloc/login_bloc/LoginResponse.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginBloc _loginBlocHelper = sl<LoginBloc>();

  LoginCubit() : super(const LoginInit());

  clearState() {
    emit(const LoginInit());
  }

  loginWithEmailPasswordPressed({required String userData}) async {
    emit(LoginWithEmailLoading(state.main.copyWith(status: FormSubmissionStatus.inProgress, message: 'Login with email and password', errorMessage: '')));
    try {
      ApiRequest request = ApiRequest(dataString: userData);
      var user = await _loginBlocHelper.tryLoginAccount(request);
      continueLogin(user!);
    } catch (error) {
      emit(LoginWithEmailError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: error.toString())));
    }
  }

  continueLogin(LoginResponse user) async {
    // if (user.user != null && user.error == null && user.authException == null) {
    //   emit(UserLoggedIn(state.main.copyWith(status: FormSubmissionStatus.success, message: 'User logged in', errorMessage: '')));
    // } else if (user.error == null && user.authException != null) {
    //   emit(LoginWithEmailError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: user.authException!.message)));
    // } else {
    //   emit(LoginError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: user.error.toString())));
    // }
  }



}
