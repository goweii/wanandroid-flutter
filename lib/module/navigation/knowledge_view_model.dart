import 'package:wanandroid/api/bean/knowledge_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/mvvm/observable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class KnowledgeViewModel extends ViewModel {
  final ObservableData<List<KnowledgeBean>> data = ObservableData([]);

  getNavi() {
    loading.value = true;
    WanApis.getKnowledges()
        .then((value) => data.value = value)
        .catchError((e) {})
        .whenComplete(() => loading.value = false);
  }
}
