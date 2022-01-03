import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/mvvm/observable_data.dart';

class ViewModel extends ChangeNotifier {
  static VM of<VM extends ViewModel>(BuildContext context) {
    return Provider.of<VM>(context, listen: false);
  }

  final ObservableData<bool> loading = ObservableData(false);

  ViewModel();
}

class ViewModelProvider<VM extends ViewModel>
    extends ChangeNotifierProvider<VM> {
  ViewModelProvider({
    Key? key,
    required Create<VM> create,
    Widget Function(BuildContext context, VM viewModel)? builder,
    Widget? child,
  }) : super(
          key: key,
          create: create,
          child: builder == null
              ? child
              : Consumer<VM>(
                  builder: (context, value, child) {
                    return builder(context, value);
                  },
                ),
        );
}
