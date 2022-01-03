import 'package:wanandroid/api/bean/navigation_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/mvvm/observable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class NavigationViewModel extends ViewModel {
  final ObservableData<List<NavigationBean>> data = ObservableData([]);

  getNavi() {
    loading.value = true;
    WanApis.getNavigations()
        .then((value) => data.value = value)
        .catchError((e) {})
        .whenComplete(() => loading.value = false);
  }
}
