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

class DataProvider2<T1 extends ChangeNotifier, T2 extends ChangeNotifier>
    extends MultiProvider {
  DataProvider2({
    Key? key,
    required Create<T1> create1,
    required Create<T2> create2,
    required Widget Function(BuildContext context, T1 data1, T2 data2) builder,
  }) : super(
          key: key,
          providers: [
            ChangeNotifierProvider(create: create1),
            ChangeNotifierProvider(create: create2),
          ],
          child: Consumer2<T1, T2>(
            builder: (context, value1, value2, child) {
              return builder(context, value1, value2);
            },
          ),
        );
}

class DataProvider3<T1 extends ChangeNotifier, T2 extends ChangeNotifier,
    T3 extends ChangeNotifier> extends MultiProvider {
  DataProvider3({
    Key? key,
    required Create<T1> create1,
    required Create<T2> create2,
    required Create<T3> create3,
    required Widget Function(BuildContext context, T1 data1, T2 data2, T3 data3)
        builder,
  }) : super(
          key: key,
          providers: [
            ChangeNotifierProvider(create: create1),
            ChangeNotifierProvider(create: create2),
            ChangeNotifierProvider(create: create3),
          ],
          child: Consumer3<T1, T2, T3>(
            builder: (context, value1, value2, value3, child) {
              return builder(context, value1, value2, value3);
            },
          ),
        );
}
