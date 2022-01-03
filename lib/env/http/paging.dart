import 'package:flutter/material.dart';

enum PagingState {
  idle,
  loading,
  succeed,
  error,
}

class StatablePagingData<T> extends ChangeNotifier {
  StatablePagingData({
    List<T>? datas,
    bool ended = false,
    PagingState state = PagingState.idle,
  }) {
    if (datas != null) {
      _datas.addAll(datas);
    }
    _ended = ended;
    _state = state;
  }

  final List<T> _datas = [];
  bool _ended = false;
  PagingState _state = PagingState.idle;

  bool get ended => _ended;
  set ended(bool ended) {
    _ended = ended;
    notifyListeners();
  }

  bool get isIdle => _state == PagingState.idle;
  bool get isLoading => _state == PagingState.loading;
  bool get isFailed => _state == PagingState.error;
  bool get isSuccess => _state == PagingState.succeed;
  PagingState get state => _state;
  set state(PagingState state) {
    _state = state;
    notifyListeners();
  }

  List<T> get datas => _datas;

  toLoading() {
    if (_state == PagingState.loading) return;
    _state = PagingState.loading;
    notifyListeners();
  }

  toError() {
    if (_state == PagingState.error) return;
    _state = PagingState.error;
    notifyListeners();
  }

  append(PagingData<T> pagingData) {
    _datas.addAll(pagingData.datas);
    _ended = pagingData.ended;
    _state = PagingState.succeed;
    notifyListeners();
  }

  reset() {
    bool changed = false;
    if (_datas.isNotEmpty) {
      _datas.clear();
      changed = true;
    }
    if (_ended) {
      _ended = false;
      changed = true;
    }
    if (!isIdle) {
      _state = PagingState.idle;
      changed = true;
    }
    if (changed) {
      notifyListeners();
    }
  }

  notify() => notifyListeners();
}

class PagingData<T> {
  PagingData({
    required this.ended,
    required this.datas,
  });

  final bool ended;
  final List<T> datas;
}

typedef PagingRequester<T> = Future<PagingData<T>> Function(int page);

class Paging<T> {
  Paging({
    required int initialPage,
    required PagingRequester<T> requester,
  })  : _initialPage = initialPage,
        _requester = requester;

  final int _initialPage;
  final PagingRequester<T> _requester;

  Future<PagingData<T>>? _loadingTask;

  int? currPage;

  bool isEnded = false;

  bool get isLoading => _loadingTask != null;

  bool get hasNext => !isEnded;

  Future<void> reset() async {
    await _loadingTask;
    currPage = null;
    isEnded = false;
    _loadingTask = null;
  }

  Future<PagingData<T>> next() async {
    await _loadingTask;
    try {
      _loadingTask = _requester(currPage ?? _initialPage);
      PagingData<T> pagingData = await _loadingTask!;
      currPage = currPage == null ? _initialPage : currPage! + 1;
      isEnded = pagingData.ended;
      return pagingData;
    } finally {
      _loadingTask = null;
    }
  }
}
