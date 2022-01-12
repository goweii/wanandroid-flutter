import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHistory extends ValueNotifier<List<String>> {
  static SearchHistory of(BuildContext context) {
    return Provider.of<SearchHistory>(context, listen: false);
  }

  static SearchHistory listen(BuildContext context) {
    return Provider.of<SearchHistory>(context, listen: true);
  }

  SearchHistory() : super([]);
}

class SearchHistoryProvider extends ChangeNotifierProvider<SearchHistory> {
  SearchHistoryProvider({Key? key})
      : super(
          key: key,
          create: (context) => SearchHistory(),
        );
}

class SearchHistoryConsumer extends Consumer<SearchHistory> {
  SearchHistoryConsumer({
    Key? key,
    required Widget Function(BuildContext context, SearchHistory searchKey)
        builder,
  }) : super(
          key: key,
          builder: (context, value, child) {
            return builder(context, value);
          },
        );
}
