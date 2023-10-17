import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/cubits/auth_bloc/register_bloc/RegisterBloc.dart';
import '../../components/api_bloc/api_req/ApiRequest.dart';
import '../../constants/constants.dart';
import '../auth_bloc/login_bloc/LoginResponse.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterBloc _registerBlocHelper = sl<RegisterBloc>();
  RegisterCubit() : super(const RegisterInit());

  clearState() {
    emit(const RegisterInit());
  }

  registerSubmitted({required String userData}) async {
    emit(RegisterLoading(state.main.copyWith(status: FormSubmissionStatus.inProgress, message: 'Registering user', errorMessage: '')));
    try {
      ApiRequest request = ApiRequest(dataString: userData);
      var user = await _registerBlocHelper.userRegister(request);
      continueRegistration(user!);
      // TPFirebaseUser user = await _authCredentialHelper.signUpWithEmailPassword(email: email.trim(), password: password.trim());
      // if (user.authException != null) {
      //   if (user.authException!.code == 'email-already-in-use') {
      //     emit(RegisterStateEmailAlreadyExists(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: user.authException!.message)));
      //   }
      // } else {
      //   continueRegistration(user);
      // }
    } catch (error, stackTrace) {
      emit(RegisterError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: error.toString()), stackTrace: stackTrace.toString()));
    }
  }

  continueRegistration(LoginResponse user) {
    // if (user.user != null && user.error == null && user.authException == null) {
    //   emit(UserRegistered(state.main.copyWith(status: FormSubmissionStatus.success, message: 'Registering user', errorMessage: '')));
    // } else if (user.error == null && user.authException != null) {
    //   emit(RegisterEmailError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: user.authException!.message)));
    // } else {
    //   emit(RegisterEmailError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: user.error)));
    // }
  }



}
