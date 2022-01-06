import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 数据提供者
/// 
/// [create] 用了生成数据，你应该在 [ViewModelProvider] 的下级提供出 [ViewModel] 中的可观察数据
/// 如果只提供了 [builder] 则可以直接消费数据
/// 如果只提供了 [child] 则可以在子控件中使用 [DataConsumer] 消费数据
class DataProvider<T extends ChangeNotifier> extends ChangeNotifierProvider<T> {
  DataProvider({
    Key? key,
    required Create<T> create,
    Widget Function(BuildContext context, T data)? builder,
    Widget? child,
  })  : assert(!(builder != null && child != null)),
        super(
          key: key,
          create: create,
          child: child ??
              Consumer<T>(
                builder: (context, value, child) {
                  return builder!(context, value);
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
    Widget Function(BuildContext context, T1 data1, T2 data2)? builder,
    Widget? child,
  })  : assert(!(builder != null && child != null)),
        super(
          key: key,
          providers: [
            ChangeNotifierProvider(create: create1),
            ChangeNotifierProvider(create: create2),
          ],
          child: child ??
              Consumer2<T1, T2>(
                builder: (context, value1, value2, child) {
                  return builder!(context, value1, value2);
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
    Widget Function(BuildContext context, T1 data1, T2 data2, T3 data3)?
        builder,
    Widget? child,
  })  : assert(!(builder != null && child != null)),
        super(
          key: key,
          providers: [
            ChangeNotifierProvider(create: create1),
            ChangeNotifierProvider(create: create2),
            ChangeNotifierProvider(create: create3),
          ],
          child: child ??
              Consumer3<T1, T2, T3>(
                builder: (context, value1, value2, value3, child) {
                  return builder!(context, value1, value2, value3);
                },
              ),
        );
}

/// 数据消费者
class DataConsumer<T extends ChangeNotifier> extends Consumer<T> {
  DataConsumer({
    Key? key,
    required Widget Function(BuildContext context, T data) builder,
  }) : super(
          key: key,
          builder: (context, value, child) {
            return builder(context, value);
          },
        );
}

class DataConsumer2<T1 extends ChangeNotifier, T2 extends ChangeNotifier>
    extends Consumer2<T1, T2> {
  DataConsumer2({
    Key? key,
    required Widget Function(BuildContext context, T1 data1, T2 data2) builder,
  }) : super(
          key: key,
          builder: (context, value1, value2, child) {
            return builder(context, value1, value2);
          },
        );
}

class DataConsumer3<T1 extends ChangeNotifier, T2 extends ChangeNotifier,
    T3 extends ChangeNotifier> extends Consumer3<T1, T2, T3> {
  DataConsumer3({
    Key? key,
    required Widget Function(BuildContext context, T1 data1, T2 data2, T3 data3)
        builder,
  }) : super(
          key: key,
          builder: (context, value1, value2, value3, child) {
            return builder(context, value1, value2, value3);
          },
        );
}
