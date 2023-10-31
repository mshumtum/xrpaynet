import 'package:equatable/equatable.dart';
import 'package:xr_paynet/constants/FormSubmissionStatus.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/responses/CountryListResponse.dart';
import 'package:xr_paynet/cubits/card_register_cubit/card_register_cubit.dart';

class MainBaseState extends Equatable {
  final String? errorMessage;
  final FormSubmissionStatus status;
  final String? token;
  final CountryListResponse? countryList;

  const MainBaseState({
    this.errorMessage,
    this.token,
    this.countryList,
    this.status = FormSubmissionStatus.initial,
  });
  @override
  List<Object?> get props => [errorMessage, token, status];

  MainBaseState copyWith({
    String? errorMessage,
    String? token,
    FormSubmissionStatus? status,
    CountryListResponse? countryList,
  }) {
    return MainBaseState(
      errorMessage: errorMessage ?? this.errorMessage,
      token: token ?? this.token,
      status: status ?? this.status,
      countryList: countryList ?? this.countryList,
    );
  }

  bool get isInProgress => status == FormSubmissionStatus.inProgress;

  bool get isFailure => status == FormSubmissionStatus.failure;

  bool get isSuccess => status == FormSubmissionStatus.success;

  bool get isInitial => status == FormSubmissionStatus.initial;

  bool get isCanceled => status == FormSubmissionStatus.canceled;
  bool get isOtpSent => status == FormSubmissionStatus.pending;
}

abstract class BaseState extends Equatable {
  final MainBaseState main;

  const BaseState(this.main);

  @override
  List<Object> get props => [main];
}

class BaseInit extends BaseState {
  const BaseInit() : super(const MainBaseState());
}

class BaseLoading extends BaseState {
  const BaseLoading(MainBaseState main) : super(main);
}

class BaseError extends BaseState {
  const BaseError(MainBaseState main) : super(main);
}

class BaseSuccess extends BaseState {
  const BaseSuccess(MainBaseState main) : super(main);
}
