import 'package:wanandroid/api/wan/bean/knowledge_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class KnowledgeViewModel extends ViewModel {
  final StatablePagingData<KnowledgeBean> data = StatablePagingData();

  Future<bool> getData() async {
    data.toLoading();
    try {
      var list = await WanApis.getKnowledges();
      data.replace(PagingData(ended: true, datas: list));
      return true;
    } catch (_) {
      data.toError();
      return false;
    }
  }
}
