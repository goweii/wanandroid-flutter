import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnreadModel extends ChangeNotifier {
  static final UnreadModel _instance = UnreadModel._();

  static UnreadModel value(BuildContext context) {
    return Provider.of<UnreadModel>(context, listen: false);
  }

  static UnreadModel listen(BuildContext context) {
    return Provider.of<UnreadModel>(context, listen: true);
  }

  int _unreadMsgCount;

  UnreadModel._({
    int unreadMsgCount = 0,
  }) : _unreadMsgCount = unreadMsgCount;

  factory UnreadModel() => _instance;

  int get unreadMsgCount => _unreadMsgCount;

  set unreadMsgCount(int count) {
    count = count > 0 ? count : 0;
    if (_unreadMsgCount != count) {
      _unreadMsgCount = count;
      notifyListeners();
    }
  }
}

class UnreadModelProvider extends ChangeNotifierProvider<UnreadModel> {
  UnreadModelProvider({
    Key? key,
  }) : super(
          key: key,
          create: (context) => UnreadModel(),
        );
}

class UnreadModelConsumer extends Consumer<UnreadModel> {
  UnreadModelConsumer({
    Key? key,
    required Widget Function(BuildContext context, UnreadModel unreadModel)
        builder,
  }) : super(
          key: key,
          builder: (context, value, child) {
            return builder(context, value);
          },
        );
}
