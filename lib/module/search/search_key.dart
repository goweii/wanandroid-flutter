import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchKey extends ValueNotifier<String> {
  static SearchKey of(BuildContext context) {
    return Provider.of<SearchKey>(context, listen: false);
  }

  static SearchKey listen(BuildContext context) {
    return Provider.of<SearchKey>(context, listen: true);
  }

  SearchKey() : super('');
}

class SearchKeyProvider extends ChangeNotifierProvider<SearchKey> {
  SearchKeyProvider({Key? key})
      : super(
          key: key,
          create: (context) => SearchKey(),
        );
}

class SearchKeyConsumer extends Consumer<SearchKey> {
  SearchKeyConsumer({
    Key? key,
    required Widget Function(BuildContext context, SearchKey searchKey) builder,
  }) : super(
          key: key,
          builder: (context, value, child) {
            return builder(context, value);
          },
        );
}
