import 'package:equatable/equatable.dart';
import 'package:xr_paynet/constants/FormSubmissionStatus.dart';
import 'package:xr_paynet/cubits/user_cubit/response/UserReponse.dart';

class MainUserState extends Equatable {
  final String? errorMessage;
  final FormSubmissionStatus status;
  final UserInfo? userInfo;

  const MainUserState({
    this.errorMessage,
    this.userInfo,
    this.status = FormSubmissionStatus.initial,
  });
  @override
  List<Object?> get props => [errorMessage, userInfo, status];

  MainUserState copyWith({
    String? errorMessage,
    String? token,
    FormSubmissionStatus? status,
    UserInfo? userInfo,
  }) {
    return MainUserState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  bool get isInProgress => status == FormSubmissionStatus.inProgress;

  bool get isFailure => status == FormSubmissionStatus.failure;

  bool get isSuccess => status == FormSubmissionStatus.success;

  bool get isInitial => status == FormSubmissionStatus.initial;

  bool get isCanceled => status == FormSubmissionStatus.canceled;
  bool get isOtpSent => status == FormSubmissionStatus.pending;
}

abstract class UserState extends Equatable {
  final MainUserState main;

  const UserState(this.main);

  @override
  List<Object> get props => [main];
}

class BaseInit extends UserState {
  const BaseInit() : super(const MainUserState());
}

class BaseLoading extends UserState {
  const BaseLoading(MainUserState main) : super(main);
}

class BaseError extends UserState {
  const BaseError(MainUserState main) : super(main);
}

class BaseSuccess extends UserState {
  const BaseSuccess(MainUserState main) : super(main);
}
