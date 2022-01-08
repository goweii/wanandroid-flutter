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

  bool _disposed = false;

  bool get ended => _ended;
  set ended(bool ended) {
    _ended = ended;
    notify();
  }

  bool get isIdle => _state == PagingState.idle;
  bool get isLoading => _state == PagingState.loading;
  bool get isFailed => _state == PagingState.error;
  bool get isSuccess => _state == PagingState.succeed;
  PagingState get state => _state;
  set state(PagingState state) {
    _state = state;
    notify();
  }

  List<T> get datas => _datas;

  toLoading() {
    if (_state == PagingState.loading) return;
    _state = PagingState.loading;
    notify();
  }

  toError() {
    if (_state == PagingState.error) return;
    _state = PagingState.error;
    notify();
  }

  append(PagingData<T> pagingData) {
    _datas.addAll(pagingData.datas);
    _ended = pagingData.ended;
    _state = PagingState.succeed;
    notify();
  }

  replace(PagingData<T> pagingData) {
    _datas.clear();
    _datas.addAll(pagingData.datas);
    _ended = pagingData.ended;
    _state = PagingState.succeed;
    notify();
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
      notify();
    }
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

  bool get isInitialPage => currPage == null || currPage == _initialPage;

  Future<void> reset() async {
    await _loadingTask;
    currPage = null;
    isEnded = false;
    _loadingTask = null;
  }

  Future<PagingData<T>> next() async {
    await _loadingTask;
    try {
      int page = currPage == null ? _initialPage : currPage! + 1;
      _loadingTask = _requester(page);
      PagingData<T> pagingData = await _loadingTask!;
      currPage = page;
      isEnded = pagingData.ended;
      return pagingData;
    } finally {
      _loadingTask = null;
    }
  }
}
