abstract class BaseState {
  const BaseState();
}

class InitialState extends BaseState {}

class LoadingState<T> extends BaseState {
  const LoadingState({this.data});

  final T? data;
}

class SuccessState<T> extends BaseState {
  const SuccessState({this.data});

  final T? data;
}

class ErrorState<T> extends BaseState {
  const ErrorState({this.data});

  final T? data;
}
