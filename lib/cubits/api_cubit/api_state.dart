part of 'api_cubit.dart';

class MainApiState extends Equatable {
  final String? message;
  final String? errorMessage;

  const MainApiState({this.message, this.errorMessage});

  @override
  List<Object?> get props => [message, errorMessage];

  MainApiState copyWith({
    String? message,
    String? errorMessage,
  }) {
    return MainApiState(
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

abstract class ApiState extends Equatable {
  final MainApiState main;

  const ApiState(this.main);

  @override
  List<Object> get props => [main];
}

class ApiInitial extends ApiState {
  const ApiInitial() : super(const MainApiState());
}

class ApiError extends ApiState {
  final String? stackTrace;

  ApiError(MainApiState mainApiState, {this.stackTrace}) : super(mainApiState) {
    if (kDebugMode) {
      log('ERROR: ${mainApiState.errorMessage!}');
      log('ERROR: $stackTrace');
    }
  }
}
