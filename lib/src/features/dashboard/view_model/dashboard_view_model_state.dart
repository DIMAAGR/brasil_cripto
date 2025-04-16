sealed class DashboardViewModelState<E, S> {
  final S? _success;
  final E? _error;
  DashboardViewModelState(this._success, this._error);
}

class InitialState<E, S> extends DashboardViewModelState<E, S> {
  InitialState() : super(null, null);
}

class LoadingState<E, S> extends DashboardViewModelState<E, S> {
  LoadingState() : super(null, null);
}

class SuccessState<E, S> extends DashboardViewModelState<E, S> {
  SuccessState(S success) : super(success, null);

  S get success => _success!;
}

class ErrorState<E, S> extends DashboardViewModelState<E, S> {
  ErrorState(E error) : super(null, error);

  E get error => _error!;
}
