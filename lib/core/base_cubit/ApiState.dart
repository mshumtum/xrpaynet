abstract class ApiState {}

class InitTodoState extends ApiState {}

class LoadingTodoState extends ApiState {}
class NoInternetState extends ApiState {

}

class ErrorTodoState<T> extends ApiState {
  final T data;
  ErrorTodoState(this.data);
}

class ResponseTodoState<T> extends ApiState {
  final T data;
  ResponseTodoState(this.data);
}



