import 'package:wanandroid/env/mvvm/observable_data.dart';

enum State {
  idle,
  loading,
  succeed,
  error,
}

class StatableData<T> extends ObservableData<T> {
  StatableData(T value) : super(value);

  State _state = State.idle;

  bool _disposed = false;

  @override
  set value(T newValue) {
    bool needNotity = false;
    if (state != State.succeed) {
      state = State.succeed;
      needNotity = true;
    }
    if (value != newValue) {
      super.value = newValue;
      needNotity = false;
    }
    if (needNotity) {
      notify();
    }
  }

  bool get isIdle => _state == State.idle;
  bool get isLoading => _state == State.loading;
  bool get isFailed => _state == State.error;
  bool get isSuccess => _state == State.succeed;
  State get state => _state;
  set state(State state) {
    _state = state;
    notify();
  }

  toLoading() {
    if (_state == State.loading) return;
    _state = State.loading;
    notify();
  }

  toError() {
    if (_state == State.error) return;
    _state = State.error;
    notify();
  }

  notify() {
    if (_disposed) {
      return;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
