import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModel extends ChangeNotifier {
  static VM of<VM extends ViewModel>(BuildContext context) {
    return Provider.of<VM>(context, listen: false);
  }
}

class ViewModelProvider<VM extends ViewModel>
    extends ChangeNotifierProvider<VM> {
  ViewModelProvider({
    Key? key,
    required Create<VM> create,
    required Widget Function(BuildContext context, VM viewModel) builder,
  }) : super(
          key: key,
          create: create,
          child: Consumer<VM>(
            builder: (context, value, child) {
              return builder(context, value);
            },
          ),
        );
}
