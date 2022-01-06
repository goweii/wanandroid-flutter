import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';

/// MVVM 中的 VM 层
/// 持有 [ObservableData] 或者 [StatableData] 等继承自 [ChangeNotifier] 的数据
class ViewModel extends ChangeNotifier {
  static VM of<VM extends ViewModel>(BuildContext context) {
    return Provider.of<VM>(context, listen: false);
  }
}

/// 提供 VM
/// 这里可以直接传入 [provide] 来暴露数据，到那时要注意反省必须写上
/// 如：
/// provide: (viewModel) => [
///   DataProvider<UserBean>(create: (_) => viewModel.userStatableData),
/// ]
class ViewModelProvider<VM extends ViewModel>
    extends ChangeNotifierProvider<VM> {
  ViewModelProvider({
    Key? key,
    required Create<VM> create,
    List<DataProvider> Function(VM viewModel)? provide,
    Widget Function(BuildContext context, VM viewModel)? builder,
    Widget? child,
  })  : assert(!(builder == null && child == null)),
        assert(!(builder != null && child != null)),
        super(
          key: key,
          create: create,
          child: child ??
              Consumer<VM>(
                builder: (context, viewModel, child) {
                  if (provide == null) {
                    return builder!(context, viewModel);
                  } else {
                    return MultiProvider(
                      providers: provide.call(viewModel),
                      builder: (context, child) {
                        return builder!(context, viewModel);
                      },
                    );
                  }
                },
              ),
        );
}
