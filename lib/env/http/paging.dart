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
