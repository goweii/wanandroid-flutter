import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservableData<T> extends ValueNotifier<T> {
  ObservableData(T value) : super(value);
}

class DataProvider<T extends ChangeNotifier> extends ChangeNotifierProvider<T> {
  DataProvider({
    Key? key,
    required Create<T> create,
    required Widget Function(BuildContext context, T data) builder,
  }) : super(
          key: key,
          create: create,
          child: Consumer<T>(
            builder: (context, value, child) {
              return builder(context, value);
            },
          ),
        );
}
