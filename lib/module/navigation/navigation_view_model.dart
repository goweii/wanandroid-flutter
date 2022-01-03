import 'package:wanandroid/api/bean/navigation_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class NavigationViewModel extends ViewModel {
  final StatablePagingData<NavigationBean> data = StatablePagingData();

  Future<bool> getData() async {
    data.toLoading();
    try {
      var list = await WanApis.getNavigations();
      data.append(PagingData(ended: true, datas: list));
      return true;
    } catch (_) {
      data.toError();
      return false;
    }
  }
}
