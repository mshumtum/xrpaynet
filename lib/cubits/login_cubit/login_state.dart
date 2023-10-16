part of 'login_cubit.dart';

class MainLoginState extends Equatable {
  final String? message;
  final String? errorMessage;
  final bool emailError;
  final bool passwordError;
  final String? sessionInfo;
  final String? verificationID;
  final FormSubmissionStatus status;

  const MainLoginState({
    this.message,
    this.errorMessage,
    this.emailError = false,
    this.passwordError = false,
    this.status = FormSubmissionStatus.initial,
    this.sessionInfo,
    this.verificationID,
  });

  @override
  List<Object?> get props => [message, errorMessage, emailError, passwordError, sessionInfo, verificationID, status];

  MainLoginState copyWith({
    String? message,
    String? errorMessage,
    bool? emailError,
    bool? passwordError,
    String? sessionInfo,
    String? verificationID,
    FormSubmissionStatus? status,
  }) {
    return MainLoginState(
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      sessionInfo: sessionInfo ?? this.sessionInfo,
      verificationID: verificationID ?? this.verificationID,
      status: status ?? this.status,
    );
  }

  bool get isInProgress => status == FormSubmissionStatus.inProgress;

  bool get isFailure => status == FormSubmissionStatus.failure;

  bool get isSuccess => status == FormSubmissionStatus.success;

  bool get isInitial => status == FormSubmissionStatus.initial;

  bool get isCanceled => status == FormSubmissionStatus.canceled;
}

abstract class LoginState extends Equatable {
  final MainLoginState main;

  const LoginState(this.main);

  @override
  List<Object> get props => [main];
}

class LoginInit extends LoginState {
  const LoginInit() : super(const MainLoginState());
}

class LoginWithEmailLoading extends LoginState {
  const LoginWithEmailLoading(MainLoginState main) : super(main);
}

class LoginWithEmailError extends LoginState {
  const LoginWithEmailError(MainLoginState main) : super(main);
}

class UserLoggedIn extends LoginState {
  const UserLoggedIn(MainLoginState main) : super(main);
}

class LoginEmailChanged extends LoginState {
  const LoginEmailChanged(MainLoginState main) : super(main);
}
class LoginPasswordChanged extends LoginState {
  const LoginPasswordChanged(MainLoginState main) : super(main);
}

class LoginError extends LoginState {
  final String? stackTrace;

  LoginError(MainLoginState main, {this.stackTrace}) : super(main) {
    if (kDebugMode) {
      log('ERROR: ${main.errorMessage!}');
      log('ERROR: $stackTrace');
    }
  }
}
