part of 'card_register_cubit.dart';

class MainRegisterState extends Equatable {
  final String? message;
  final String? errorMessage;
  final bool emailError;
  final bool passwordError;
  final bool confirmPasswordError;
  final String? password;
  final FormSubmissionStatus status;

  const MainRegisterState({
    this.message,
    this.errorMessage,
    this.emailError = false,
    this.passwordError = false,
    this.confirmPasswordError = false,
    this.password,
    this.status = FormSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
        message,
        errorMessage,
        emailError,
        passwordError,
        confirmPasswordError,
        password,
        status
      ];

  MainRegisterState copyWith({
    String? message,
    String? errorMessage,
    bool? emailError,
    bool? passwordError,
    bool? confirmPasswordError,
    String? password,
    FormSubmissionStatus? status,
  }) {
    return MainRegisterState(
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  bool get isInProgress => status == FormSubmissionStatus.inProgress;

  bool get isFailure => status == FormSubmissionStatus.failure;

  bool get isSuccess => status == FormSubmissionStatus.success;

  bool get isInitial => status == FormSubmissionStatus.initial;

  bool get isCanceled => status == FormSubmissionStatus.canceled;
}

abstract class RegisterState extends Equatable {
  final MainRegisterState main;

  const RegisterState(this.main);

  @override
  List<Object> get props => [main];
}

class RegisterInit extends RegisterState {
  const RegisterInit() : super(const MainRegisterState());
}

class RegisterLoading extends RegisterState {
  const RegisterLoading(MainRegisterState main) : super(main);
}

class RegisterStatePasswordResetSuccess extends RegisterState {
  const RegisterStatePasswordResetSuccess(MainRegisterState main) : super(main);
}

class EmailChanged extends RegisterState {
  const EmailChanged(MainRegisterState main) : super(main);
}

class PasswordChanged extends RegisterState {
  const PasswordChanged(MainRegisterState main) : super(main);
}

class ConfirmPasswordChanged extends RegisterState {
  const ConfirmPasswordChanged(MainRegisterState main) : super(main);
}

class TryingToSignInUser extends RegisterState {
  const TryingToSignInUser(MainRegisterState main) : super(main);
}

class RegisterStateEmailAlreadyExists extends RegisterState {
  const RegisterStateEmailAlreadyExists(MainRegisterState main) : super(main);
}

class RegisterEmailError extends RegisterState {
  const RegisterEmailError(MainRegisterState main) : super(main);
}

class UserRegistered extends RegisterState {
  const UserRegistered(MainRegisterState main) : super(main);
}

class RegisterError extends RegisterState {
  final String? stackTrace;

  RegisterError(MainRegisterState main, {this.stackTrace}) : super(main) {
    if (kDebugMode) {
      log('ERROR: ${main.errorMessage!}');
      log('ERROR: $stackTrace');
    }
  }
}
