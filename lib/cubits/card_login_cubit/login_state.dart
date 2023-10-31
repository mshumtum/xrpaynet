part of 'card_login_cubit.dart';

class MainLoginState extends Equatable {
  final String? message;
  final String? errorMessage;
  final bool emailError;
  final bool passwordError;
  final String? sessionInfo;
  final String? verificationID;
  final FormSubmissionStatus status;
  final int attempt;
  final int counter;
  final bool isTimerRunning;
  final int timestampOnStart;

  const MainLoginState({
    this.message,
    this.errorMessage,
    this.emailError = false,
    this.passwordError = false,
    this.status = FormSubmissionStatus.initial,
    this.sessionInfo,
    this.verificationID,
    this.attempt = 5,
    this.counter = 60,
    this.isTimerRunning = false,
    this.timestampOnStart = 0,
  });

  @override
  List<Object?> get props => [
        message,
        errorMessage,
        emailError,
        passwordError,
        sessionInfo,
        verificationID,
        status,
        attempt,
        counter,
        isTimerRunning,
        timestampOnStart,
      ];

  MainLoginState copyWith({
    String? message,
    String? errorMessage,
    bool? emailError,
    bool? passwordError,
    String? sessionInfo,
    String? verificationID,
    FormSubmissionStatus? status,
    int? attempt,
    int? counter,
    bool? isTimerRunning,
    int? timestampOnStart,
  }) {
    return MainLoginState(
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      sessionInfo: sessionInfo ?? this.sessionInfo,
      verificationID: verificationID ?? this.verificationID,
      status: status ?? this.status,
      attempt: attempt ?? this.attempt,
      counter: counter ?? this.counter,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      timestampOnStart: timestampOnStart ?? this.timestampOnStart,
    );
  }

  bool get isInProgress => status == FormSubmissionStatus.inProgress;

  bool get isFailure => status == FormSubmissionStatus.failure;

  bool get isSuccess => status == FormSubmissionStatus.success;

  bool get isInitial => status == FormSubmissionStatus.initial;

  bool get isCanceled => status == FormSubmissionStatus.canceled;

  bool get isVerificationPending => status == FormSubmissionStatus.pending;
  bool get isAttemptFail => status == FormSubmissionStatus.attemptFail;
  bool get checkAttemptFailTime =>
      status == FormSubmissionStatus.checkAttemptFailTime;
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

class LoginAttemptState extends LoginState {
  const LoginAttemptState(MainLoginState main) : super(main);
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
